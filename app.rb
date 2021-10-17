# frozen_string_literal: true

require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?

set :port, 4040

namespace '/api' do
  namespace '/v1' do
    get '/' do
      content_type :json
      json status: 'OK'
    end
  end
end
