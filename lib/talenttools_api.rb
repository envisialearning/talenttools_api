require "talenttools_api/version"
require "her"

module TalenttoolsApi
  class << self
    attr_accessor :api_key, :url

    def api
      @api ||= Her::API.new    
    end

    def configure
      yield self

      TalenttoolsApi::api.setup url: self.url do |c|
        c.headers["Authorization"] = "Token token=#{api_key}"

        # Request
        c.use Faraday::Request::UrlEncoded

        # Response
        c.use Her::Middleware::DefaultParseJSON

        #c.use MyCustomParser

        # Adapter
        c.use Faraday::Adapter::NetHttp
      end  

      require "talenttools_api/project"
      require "talenttools_api/participant"
    end
  end
end
