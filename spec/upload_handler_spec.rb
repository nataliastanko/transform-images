# frozen_string_literal: true

require_relative '../lib/services/upload_handler'
require 'fileutils'
require 'tempfile'

RSpec.describe UploadHandler do
  describe '#copy_uploaded_file' do
    let(:image_bags) { 'home-made&bągs).gif' }
    let(:image_bags_dir) { 'data/home-made&bągs).gif' }
    let(:tempfile) { Tempfile.new(image_bags) }

    context 'when arguments valid' do
      it 'copies tmp file into destination folder' do
        expect(described_class.new(image_bags, tempfile).copy_uploaded_file).to eq './tmp/home-made&bągs).gif'
      end
    end

    context 'when arguments invalid' do
      let(:invalid_service_call) { described_class.new(image_bags_dir, nil).copy_uploaded_file }
      it 'raises exception' do
        expect { invalid_service_call }.to raise_error(ArgumentError, 'Invalid parameters')
      end
    end
  end
end
