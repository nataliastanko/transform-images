# frozen_string_literal: true

require_relative '../lib/services/upload_handler'
require 'tempfile'

RSpec.describe UploadHandler do
  describe '#process_upload' do
    context 'when arguments valid' do
      it 'returns uploaded image' do
        temp = Tempfile.new('home-made&bągs).gif')
        temp.write(File.open('data/home-made&bągs).gif', 'rb').read)
        temp.rewind
        temp.close

        image_bags = { filename: 'home-made&bągs).gif', tempfile: temp }
        image = described_class.new(image_bags).process_upload
        expect(image).to be_a Image
      end
    end

    context 'when arguments invalid' do
      let(:invalid_service_call) { described_class.new({}, nil).process_upload }

      it 'raises exception' do
        expect { invalid_service_call }.to raise_error(ArgumentError, 'Invalid parameters')
      end
    end
  end
end
