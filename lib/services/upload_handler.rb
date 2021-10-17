# frozen_string_literal: true

require_relative '../utils/file_gen_utils'

##
# Help with sinatra file uploads
class UploadHandler
  include FileGenUtils

  def initialize(filename, tempfile, tmp_dir = './tmp/')
    @filename = filename
    @tempfile = tempfile
    @tmp_dir = tmp_dir
    @input_image_path = "#{tmp_dir}#{filename}"
  end

  def copy_uploaded_file
    create_directory @tmp_dir
    FileUtils.copy(@tempfile.path, @input_image_path)
    @input_image_path
  end
end
