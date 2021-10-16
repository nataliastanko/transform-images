# frozen_string_literal: true

require 'mini_magick'
require_relative 'file_handler'

##
# Images
class Image < FileHandler
  def initialize(file_path)
    super
    @accepted_formats = %w[JPEG PNG HEIC]
  end

  def image?
    @image = MiniMagick::Image.open(@file_path)
    valid_image?
  end

  private

  # raises MiniMagick::Invalid if not supported by imagemagic
  # raises StandardError if not in app accepted format
  def valid_image?
    @image.validate!
    raise StandardError, 'File format not accepted' unless @accepted_formats.include? @image.type

    true
  end
end
