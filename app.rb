# frozen_string_literal: true

require 'sinatra'
require 'sinatra/contrib'
require_relative 'lib/services/upload_handler'
require_relative 'lib/services/params_validator'
require_relative 'lib/img_transformer'

set :port, 4040
set :public_folder, 'uploads/resized'

namespace '/api' do
  namespace '/v1' do
    get '/' do
      content_type :json
      json status: 'OK'
    end

    post '/metadata' do
      begin
        params = ParamsValidator.new(request.params).validate
        image = UploadHandler.new(params['file']).process_upload
      rescue ArgumentError => e
        logger.error(e.message)
        halt 422, json({ error: e })
      end

      content_type :json
      json image.metadata
    end

    post '/resize' do
      begin
        params = ParamsValidator.new(request.params).validate
        image = UploadHandler.new(params['file']).process_upload
        filepath = "#{request.env['HTTP_HOST']}/#{image.resize.basename}"
      rescue ArgumentError => e
        logger.error(e.message)
        halt 422, json({ error: e })
      end

      content_type :json
      json({ filepath: filepath })
    end
  end
end
