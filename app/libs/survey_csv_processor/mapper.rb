# frozen_string_literal: true

require "csv"

module SurveyCSVProcessor
  class Mapper
    attr_reader :filename, :csv, :headers, :rows

    def initialize(filename)
      @filename = filename
      @csv = CSV.read(csv_input_path(filename), liberal_parsing: true)
      @headers, *@rows = @csv.map { |row| row[0].split(";") }
    end

    def translated_headers
      @mapped_headers ||= headers.map { |header| translate_key(header) }
    end

    def mapped_responses
      @mapped_responses ||= rows.map do |row|
        response = translated_headers.zip(row).to_h
        participant_data = response.slice(*participant_keys)
        response_data = response.slice(*(question_keys + comment_keys + ["response_date"]))

        [response["name"], participant_data, response_data]
      end
    end

    def inject!
      ActiveRecord::Base.transaction do
        survey = Survey.find_or_initialize_by(title: "Test survey", start_date: Time.current, end_date: Time.current)
        survey.save(validate: false)
        poll = survey.polls.find_or_create_by!(title: "Survey test poll")

        pp "Survey: #{survey.id}, Poll: #{poll.id}"
        pp "Survey responses: #{mapped_responses.size}"
        pp "Poll Questions: #{question_keys.size}"

        pp "- Injecting poll questions..."
        mapped_questions = {}
        question_keys.each do |key|
          question = poll.questions.find_or_create_by!(prompt: translate_key(key, locale: :pt), kind: "nps")
          mapped_questions[key] = question
        end

        responses = []
        mapped_responses.each do |(name, participant_data, response_data)|
          pp "- Injecting participant: #{name}"
          participant = survey.participants.find_or_create_by!(participant_data)

          pp "- Mapping participant #{participant.id} - #{participant.name} responses..."
          response_data.map do |key, value|
            question = mapped_questions[key]
            next unless question

            responses << {
              survey_participant_id: participant.id,
              survey_question_id: question.id,
              answer: value.to_i,
              answered_at: response_data["response_date"],
              comment: response_data["#{key}_comments"]
            }
          end
        end

        pp "- Injecting responses"
        Survey::Response.insert_all(responses)

        pp "Completed!"
      rescue => error
        Rails.logger.error(error.message)
        raise ActiveRecord::Rollback
      end
    end

    private
      def csv_input_path(filename)
        file = Rails.root.join("app/libs/survey_csv_processor/mapper/input", "#{filename}.csv")
        raise "File doesnt exist: #{file}" unless File.exist?(file)

        file
      end

      def participant_keys
        Survey::Participant.attribute_names - %w[created_at updated_at survey_id]
      end

      def question_keys
        %w[job_interest contribution learning_and_development feedback manager_interaction career_opportunities_clarity retention_expectation enps]
      end

      def comment_keys
        %w[job_interest_comments contribution_comments learning_and_development_comments feedback_comments manager_interaction_comments career_opportunities_clarity_comments retention_expectation_comments enps_comments]
      end

      def translate_key(key, scope: "libs.survey_processor.headers", locale: :en)
        I18n.locale = locale
        I18n.t(key, scope: scope)
      end
  end
end
