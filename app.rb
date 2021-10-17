# frozen_string_literal: true

require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require_relative 'lib/services/upload_handler'
require_relative 'lib/img_transformer'

set :port, 4040

namespace '/api' do
  namespace '/v1' do
    get '/' do
      content_type :json
      json status: 'OK'
    end

    post '/metadata' do
      filename = request.params['file'][:filename]
      tempfile = request.params['file'][:tempfile]

      input_image_path = UploadHandler.new(filename, tempfile).copy_uploaded_file

      image = Image.new input_image_path

      content_type :json
      json image.metadata
    end
  end
end
