class TalenttoolsApi::Project
  include Her::Model

  collection_path "/api/v1/projects"

  parse_root_in_json :project
  include_root_in_json true

  use_api TalenttoolsApi.api

  custom_get :get_report_types
  
  class << self
    def create(params = {})
      post "/api/v1/projects", params
    end

    def update(guid, params = {})
      patch "/api/v1/projects/#{guid}", params
    end

    def get_report_types(guid)
      get "/api/v1/projects/#{guid}/get_report_types"
    end
  end
end