# frozen_string_literal: true

require_relative '../image'

RSpec.describe Image do
  describe '#is_image?' do
    context 'when input file is an image' do
      let(:image) { ->(file_path) { described_class.new(file_path) } }

      it 'returns true' do
        expect(image.call('data/books.jpeg').image?).to eq true
        expect(image.call('data/Holborn.jpg').image?).to eq true
        expect(image.call('data/Brighton.heic').image?).to eq true
      end
    end

    context 'when input file is not an image' do
      subject(:not_image) { described_class.new('data/pdf/ImageMagick.pdf') }

      it 'returns false' do
        expect(not_image.image?).to eq false
      end
    end
  end
end
