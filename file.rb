# frozen_string_literal: true

##
# Class for locating and validating the file
class File
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def valid_path?
    File.exist?(@file_path)
  end
end
