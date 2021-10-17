# frozen_string_literal: true

require 'fileutils'
require 'securerandom'

##
# File generation utilities
module FileGenUtils
  def create_directory(dir)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
  end

  def random
    SecureRandom.hex 8
  end

  # class << self
  #   include FileGenUtils
  # end
end
