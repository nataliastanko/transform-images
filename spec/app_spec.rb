# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require_relative '../app'
require 'rspec'
require 'rack/test'

RSpec.describe 'Image resizing API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/api' do
    describe '/v1' do
      it 'responds with OK status on /' do
        get '/api/v1/'
        expect(last_response).to be_ok
        expect(last_response.content_type).to eq 'application/json'

        expected = JSON.generate({ status: 'OK' })
        expect(last_response.body).to eq(expected)
      end
    end
  end
end
