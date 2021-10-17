# frozen_string_literal: true

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

      describe '/metadata' do
        context 'valid request parameters' do
          it 'responds with image metada' do
            post '/api/v1/metadata', file: Rack::Test::UploadedFile.new('data/Greenwich.PNG', 'image/png')

            expect(last_response).to be_ok
            expect(last_response.content_type).to eq 'application/json'

            expected = JSON.generate({ type: 'PNG', size: 108_442, dimensions: { width: 640, height: 1136 } })
            expect(last_response.body).to eq(expected)
          end
        end

        context 'invalid request parameters' do
          let(:txt) { Rack::Test::UploadedFile.new('data/text/file.txt', 'text/plain') }
          let(:pdf) { Rack::Test::UploadedFile.new('data/pdf/ImageMagick.pdf', 'application/pdf') }

          it 'responds with error when request param is missing' do
            post '/api/v1/metadata', file: nil
            expect(last_response.status).to be 422

            expected = JSON.generate({ error: 'Parameter file is required' })
            expect(last_response.body).to eq(expected)
          end

          it 'responds with error when non image file parameter' do
            post '/api/v1/metadata', file: txt
            expect(last_response.status).to be 422

            expected = JSON.generate({ error: 'File format not an image' })
            expect(last_response.body).to eq(expected)
          end

          it 'responds with error when image format is not accepted by the app ' do
            post '/api/v1/metadata', file: pdf
            expect(last_response.status).to be 422

            expected = JSON.generate({ error: 'File format not accepted' })
            expect(last_response.body).to eq(expected)
          end
        end
      end
    end
  end
end
