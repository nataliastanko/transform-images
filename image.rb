# frozen_string_literal: true

##
# Images
class Image < File
  def initialize(file_path)
    super
    @accepted_formats = ['.jpg', '.jpeg', '.png', '.gif', '.heic']
  end

  def image?
    valid_extension?
  end

  private

  def valid_extension?
    @accepted_formats.include? extension
  end
end
