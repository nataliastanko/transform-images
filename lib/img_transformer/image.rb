# frozen_string_literal: true

require 'mini_magick'

##
# Images
class Image < FileHandler
  ACCEPTED_FORMATS = %w[JPEG PNG HEIC GIF].freeze
  RESIZE_TO = '100x100'

  def initialize(file_path, upload_dir = 'uploads/resized/')
    super(file_path, upload_dir)
    validate_image
  end

  def metadata
    { type: @image.type, size: @image.size, dimensions: dimensions }
  end

  def dimensions
    { width: @image.width, height: @image.height }
  end

  def resize
    create_directory(@upload_dir)
    @image.resize RESIZE_TO
    @image.write new_file_path
    new_file_path
  end

  private

  # raises ArgumentError if file not supported by imagemagic
  # raises ArgumentError if file not in app accepted format
  def validate_image
    begin
      @image = MiniMagick::Image.open(@file_path)
      @image.validate!
    rescue MiniMagick::Invalid
      raise ArgumentError, 'File format not an image'
    end

    raise ArgumentError, 'File format not accepted' unless ACCEPTED_FORMATS.include? @image.type
  end
end
