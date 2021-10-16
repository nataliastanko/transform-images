# frozen_string_literal: true

require 'fileutils'

##
# Class for locating and validating the file
class FileHandler
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    @upload_dir = 'uploads/resized/'
    validate_path
  end

  protected

  def new_file_path
    filename = File.basename(file_path)
    "#{@upload_dir}random_#{filename}"
  end

  private

  # raises ArgumentError if file does not exist
  def validate_path
    raise ArgumentError, 'File does not exist' unless File.exist?(@file_path)
  end

  def create_directory
    FileUtils.mkdir_p(@upload_dir) unless File.directory?(@upload_dir)
  end
end
