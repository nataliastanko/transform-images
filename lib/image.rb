# frozen_string_literal: true

require 'mini_magick'
require_relative 'file_handler'

##
# Images
class Image < FileHandler
  ACCEPTED_FORMATS = %w[JPEG PNG HEIC].freeze
  RESIZE_TO = '100x100'

  def initialize(file_path)
    super
    @image = MiniMagick::Image.open(@file_path)
    validate_image
  end

  def metadata
    { type: @image.type, size: @image.size, dimensions: dimensions }
  end

  def dimensions
    { width: @image.width, height: @image.height }
  end

  def resize
    create_directory
    @image.resize RESIZE_TO
    @image.write new_file_path
    new_file_path
  end

  private

  # raises MiniMagick::Invalid if not supported by imagemagic
  # raises StandardError if not in app accepted format
  def validate_image
    @image.validate!
    raise StandardError, 'File format not accepted' unless ACCEPTED_FORMATS.include? @image.type
  end
end
