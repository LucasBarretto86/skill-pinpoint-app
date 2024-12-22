# frozen_string_literal: true

class API::SurveysController < APIController
  def index
    @surveys = Survey.includes(:participants, polls: { questions: :responses })

    if pagination_params.present?
      @paginated_surveys = PaginationService.new(@surveys, page: pagination_params[:page], per_page: pagination_params[:per_page], serializer: SurveySerializer).paginate
      render json: @paginated_surveys
    else
      render json: @surveys
    end
  end

  def pagination_params
    params.permit(:page, :per_page)
  end
end
