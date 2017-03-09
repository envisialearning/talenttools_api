$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'talenttools_api'

require 'minitest/autorun'

TalenttoolsApi.configure do |c|
  c.api_key = "123456"
  c.url = "http://freetools.dev"
end