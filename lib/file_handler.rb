# frozen_string_literal: true

require 'fileutils'
require_relative 'file_gen_utils'

##
# Class for locating and validating the file
class FileHandler
  include FileGenUtils

  attr_reader :file_path, :new_file_path

  def initialize(file_path, upload_dir = 'uploads')
    @file_path = file_path
    validate_path
    @upload_dir = upload_dir
    @new_file_path = build_new_file_path
  end

  private

  def build_new_file_path
    filename = File.basename(file_path)
    @new_file_path = "#{@upload_dir}#{random}_#{filename}"
  end

  # raises ArgumentError if file does not exist
  def validate_path
    raise ArgumentError, 'File does not exist' unless File.exist?(@file_path)
  end

  def create_directory
    FileUtils.mkdir_p(@upload_dir) unless File.directory?(@upload_dir)
  end
end
