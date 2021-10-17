# frozen_string_literal: true

# set :environment, :production

require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require_relative 'lib/services/upload_handler'
require_relative 'lib/services/params_validator'
require_relative 'lib/img_transformer'

# configure :development do
#   disable :show_exceptions
# end

set :port, 4040
set :public_folder, 'uploads/resized'

namespace '/api' do
  namespace '/v1' do
    get '/' do
      content_type :json
      json status: 'OK'
    end

    # post '/metadata', provides: json do
    post '/metadata' do
      begin
        params = ParamsValidator.new(request.params).validate
        input_image_path = UploadHandler.new(params['file'][:filename], params['file'][:tempfile]).copy_uploaded_file
        image = Image.new input_image_path
      rescue ArgumentError => e
        halt 422, json({ error: e })
      end

      content_type :json
      json image.metadata
    end

    post '/resize' do
      begin
        params = ParamsValidator.new(request.params).validate
        input_image_path = UploadHandler.new(params['file'][:filename], params['file'][:tempfile]).copy_uploaded_file
        image = Image.new input_image_path
        filename = File.basename(image.resize)

        filepath = "#{request.env['HTTP_HOST']}/#{filename}"
      rescue ArgumentError => e
        halt 422, json({ error: e })
      end

      content_type :json
      json({ filepath: filepath })
    end
  end
end
