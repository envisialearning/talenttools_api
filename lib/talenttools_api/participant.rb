class TalenttoolsApi::Participant
  include Her::Model

  collection_path "/api/v1/projects"

  parse_root_in_json :participant
  include_root_in_json true

  use_api TalenttoolsApi.api

  custom_get :get_assessment_link, :get_assessment_status, :get_report_link

  class << self
    def create(project_id, params = {})
      post "/api/v1/projects/#{project_id}/participants", params
    end

    def update(project_id, participant_id, params = {})
      patch "/api/v1/projects/#{project_id}/participants/#{participant_id}", params
    end

    def get_assessment_link(project_id, participant_id)
      get "/api/v1/projects/#{project_id}/participants/#{participant_id}/get_assessment_link"
    end

    def get_assessment_status(project_id, participant_id)
      get "/api/v1/projects/#{project_id}/participants/#{participant_id}/get_assessment_status"
    end

    def get_report_link(project_id, participant_id, params={})
      get "/api/v1/projects/#{project_id}/participants/#{participant_id}/get_report_link", params
    end
  end
end