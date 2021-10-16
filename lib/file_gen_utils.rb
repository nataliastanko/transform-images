# frozen_string_literal: true

require 'securerandom'

##
# File generation utilities
module FileGenUtils
  def random
    SecureRandom.hex 8
  end
end
