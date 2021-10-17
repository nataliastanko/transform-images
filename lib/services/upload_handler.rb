# frozen_string_literal: true

require_relative '../img_transformer'
require_relative '../utils/file_gen_utils'

##
# Help with sinatra file uploads
class UploadHandler
  include FileGenUtils

  def initialize(file_params, tmp_dir = './tmp/')
    @filename = file_params[:filename]
    @tempfile = file_params[:tempfile]
    @tmp_dir = tmp_dir
    @input_image_path = "#{@tmp_dir}#{@filename}"
  end

  def process_upload
    copy_uploaded_file
    Image.new @input_image_path
  end

  private

  def copy_uploaded_file
    create_directory @tmp_dir
    FileUtils.copy(@tempfile.path, @input_image_path)
  rescue StandardError
    raise ArgumentError, 'Invalid parameters'
  end
end
