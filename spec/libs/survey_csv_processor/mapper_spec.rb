# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveyCSVProcessor::Mapper do
  let(:dummy_filename) { "data" }
  let(:mock_csv_data) do
    [
      ["nome;email;email_corporativo;area;cargo;funcao;localidade;tempo_de_empresa;genero;geracao;n0_empresa;n1_diretoria;n2_gerencia;n3_coordenacao;n4_area;Data da Resposta;Interesse no Cargo;Comentários - Interesse no Cargo;Contribuição;Comentários - Contribuição;Aprendizado e Desenvolvimento;Comentários - Aprendizado e Desenvolvimento;Feedback;Comentários - Feedback;Interação com Gestor;Comentários - Interação com Gestor;Clareza sobre Possibilidades de Carreira;Comentários - Clareza sobre Possibilidades de Carreira;Expectativa de Permanência;Comentários - Expectativa de Permanência;eNPS;[Aberta] eNPS"],
      ["Demo 001;demo001@pinpeople.com.br;demo001@pinpeople.com.br;administrativo;estagiário;profissional;brasília;entre 1 e 2 anos;masculino;geração z;empresa;diretoria a;gerência a1;coordenação a11;área a112;20/01/2022;7;-;1;-;1;-;6;-;6;-;6;-;2;-;5;A empresa tem um excelente ambiente de trabalho e equipe colaborativa."]
    ]
  end

  before do
    allow(CSV).to receive(:read).and_return(mock_csv_data)
  end

  describe "#initialize" do
    it "reads the CSV file and parses headers and rows" do
      mapper = described_class.new(dummy_filename)

      expect(mapper.headers).to eq([
        "nome", "email", "email_corporativo", "area", "cargo", "funcao", "localidade", "tempo_de_empresa",
        "genero", "geracao", "n0_empresa", "n1_diretoria", "n2_gerencia", "n3_coordenacao", "n4_area",
        "Data da Resposta", "Interesse no Cargo", "Comentários - Interesse no Cargo", "Contribuição",
        "Comentários - Contribuição", "Aprendizado e Desenvolvimento", "Comentários - Aprendizado e Desenvolvimento",
        "Feedback", "Comentários - Feedback", "Interação com Gestor", "Comentários - Interação com Gestor",
        "Clareza sobre Possibilidades de Carreira", "Comentários - Clareza sobre Possibilidades de Carreira",
        "Expectativa de Permanência", "Comentários - Expectativa de Permanência", "eNPS", "[Aberta] eNPS"
      ])
      expect(mapper.rows).to eq([
        [
          "Demo 001", "demo001@pinpeople.com.br", "demo001@pinpeople.com.br", "administrativo", "estagiário",
          "profissional", "brasília", "entre 1 e 2 anos", "masculino", "geração z", "empresa", "diretoria a",
          "gerência a1", "coordenação a11", "área a112", "20/01/2022", "7", "-", "1", "-", "1", "-", "6", "-",
          "6", "-", "6", "-", "2", "-", "5", "A empresa tem um excelente ambiente de trabalho e equipe colaborativa."
        ]
      ])
    end
  end

  describe "#translated_headers" do
    before do
      allow(I18n).to receive(:t).and_return("translated_key")
    end

    it "translates the CSV headers" do
      mapper = described_class.new(dummy_filename)
      expect(mapper.translated_headers).to all(eq("translated_key"))
    end
  end

  describe "#mapped_responses" do
    it "maps rows to participant and response data" do
      mapper = described_class.new(dummy_filename)

      expected_response = [["Demo 001",
        {
          "name" => "Demo 001",
          "email" => "demo001@pinpeople.com.br",
          "corporate_email" => "demo001@pinpeople.com.br",
          "department" => "administrativo",
          "position" => "estagiário",
          "function" => "profissional",
          "location" => "brasília",
          "company_tenure" => "entre 1 e 2 anos",
          "gender" => "masculino",
          "generation" => "geração z",
          "lv0_company" => "empresa",
          "lv1_directorate" => "diretoria a",
          "lv2_management" => "gerência a1",
          "lv3_coordination" => "coordenação a11",
          "lv4_area" => "área a112"
        }, {
          "job_interest" => "7",
          "contribution" => "1",
          "learning_and_development" => "1",
          "feedback" => "6",
          "manager_interaction" => "6",
          "career_opportunities_clarity" => "6",
          "retention_expectation" => "2",
          "enps" => "5",
          "job_interest_comments" => "-",
          "contribution_comments" => "-",
          "learning_and_development_comments" => "-",
          "feedback_comments" => "-",
          "manager_interaction_comments" => "-",
          "career_opportunities_clarity_comments" => "-",
          "retention_expectation_comments" => "-",
          "enps_comments" => "A empresa tem um excelente ambiente de trabalho e equipe colaborativa.",
          "response_date" => "20/01/2022"
        }
      ]]

      expect(mapper.mapped_responses).to eq(expected_response)
    end
  end

  describe "#inject!" do
    # LUCAS: Thanks GPT, I would not be able to do this test without its help
    let(:mock_survey) { instance_double(Survey, id: 1, participants: double(:participants), polls: double(:polls)) }
    let(:mock_poll) { instance_double(Survey::Poll, id: 1, questions: double(:questions)) }
    let(:participant_data) do
      {
        "nome" => "Demo 001",
        "email" => "demo001@pinpeople.com.br",
        "email_corporativo" => "demo001@pinpeople.com.br",
        "area" => "administrativo",
        "cargo" => "estagiário",
        "funcao" => "profissional",
        "localidade" => "brasília",
        "tempo_de_empresa" => "entre 1 e 2 anos",
        "genero" => "masculino",
        "geracao" => "geração z",
        "n0_empresa" => "empresa",
        "n1_diretoria" => "diretoria a",
        "n2_gerencia" => "gerência a1",
        "n3_coordenacao" => "coordenação a11",
        "n4_area" => "área a112"
      }
    end

    let(:response_data) do
      {
        "data_da_resposta" => "20/01/2022",
        "interesse_no_cargo" => "7",
        "comentarios_interesse_no_cargo" => "-",
        "contribuicao" => "1",
        "comentarios_contribuicao" => "-",
        "enps" => "5",
        "aberta_enps" => "A empresa tem um excelente ambiente de trabalho e equipe colaborativa."
      }
    end

    let(:mock_participant) { instance_double(Survey::Participant, id: 1, name: "Demo 001") }
    let(:mock_question) { instance_double(Survey::Question, id: 1) }

    let(:original_stdout) { $stdout }

    before do
      $stdout = StringIO.new

      allow(Survey).to receive(:find_or_initialize_by).and_return(mock_survey)
      allow(mock_survey).to receive(:save).and_return(true)
      allow(mock_survey.polls).to receive(:find_or_create_by!).and_return(mock_poll)
      allow(mock_poll.questions).to receive(:find_or_create_by!).and_return(mock_question)
      allow(mock_survey.participants).to receive(:find_or_create_by!).and_return(mock_participant)
      allow(Survey::Response).to receive(:insert_all)
    end

    after do
      I18n.locale = :en
      $stdout = original_stdout
    end

    it "injects data into the database" do
      # Create the mapper object
      mapper = described_class.new(dummy_filename)

      # Mock the mapped responses
      allow(mapper).to receive(:mapped_responses).and_return([
        ["Demo 001", participant_data, response_data]
      ])

      # Mock the find_or_initialize_by method for survey
      expect(Survey).to receive(:find_or_initialize_by).with(
        title: "Test survey",
        start_date: instance_of(ActiveSupport::TimeWithZone),
        end_date: instance_of(ActiveSupport::TimeWithZone)
      ).and_return(mock_survey)

      # Mock the interaction with polls and questions
      expect(mock_survey.polls).to receive(:find_or_create_by!).with(title: "Survey test poll").and_return(mock_poll)
      expect(mock_poll.questions).to receive(:find_or_create_by!).at_least(:once)

      # Mock the participant creation
      expect(mock_survey.participants).to receive(:find_or_create_by!).with(participant_data).and_return(mock_participant)

      # Mock the response insertion to prevent actual database interaction
      expect(Survey::Response).to receive(:insert_all).with(instance_of(Array))

      # The test should not actually modify the database
      mapper.inject!
    end
  end
end
