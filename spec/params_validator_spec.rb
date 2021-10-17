# frozen_string_literal: true

require_relative '../lib/services/params_validator'

RSpec.describe ParamsValidator do
  describe '#validate' do
    context 'invalid params given' do
      it 'returns error if file param is empty' do
        params = {}
        expect { described_class.new(params).validate }.to raise_error(ArgumentError, 'Parameter file is required')
      end

      it 'returns error if file param is not an expected format' do
        params = { 'file' => 'value' }
        expect { described_class.new(params).validate }.to raise_error(ArgumentError, 'Parameter file is required')
      end
    end

    context 'valid params given' do
      it 'returns params' do
        params =  { 'file' => { tempfile: '/tmp/path' } }
        expect(described_class.new(params).validate).to eq params
      end
    end
  end
end
