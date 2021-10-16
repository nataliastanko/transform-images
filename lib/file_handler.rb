# frozen_string_literal: true

##
# Class for locating and validating the file
class FileHandler
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    validate_path
  end

  private

  # raises ArgumentError if file does not exist
  def validate_path
    raise ArgumentError, 'File does not exist' unless File.exist?(@file_path)
  end
end
