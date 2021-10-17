# frozen_string_literal: true

##
# Validates upload request params
class ParamsValidator
  def initialize(params)
    @params = params
  end

  def validate
    validate_file_param
  end

  private

  ##
  # returns @params
  # raises ArgumentError if file not in app accepted format
  def validate_file_param
    if @params['file'].nil? || !@params['file'].is_a?(Hash) || @params['file'][:tempfile].nil?
      raise ArgumentError, 'Parameter file is required'
    end

    @params
  end
end
