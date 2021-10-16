# frozen_string_literal: true

require_relative '../image'

RSpec.describe Image do
  let(:image_books) { described_class.new('data/books.jpeg') }
  let(:image_holborn) { described_class.new('data/Holborn.jpg') }
  let(:image_brighton) { described_class.new('data/Brighton.heic') }
  let(:pdf) { described_class.new('data/pdf/ImageMagick.pdf') }
  let(:txt) { described_class.new('data/text/file.txt') }

  describe '#valid_image?' do
    context 'when input file is an image' do
      it 'returns true' do
        expect(image_books.valid_image?).to eq true
        expect(image_holborn.valid_image?).to eq true
        expect(image_brighton.valid_image?).to eq true
      end
    end

    context 'when input file is not an image' do
      it 'returns false' do
        expect { pdf.image? }.to raise_error(StandardError)
        expect { txt.image? }.to raise_error(MiniMagick::Invalid)
      end
    end
  end

  describe '#metadata' do
    let(:image_books_metadata) { { type: 'JPEG', size: 2_594_548, dimensions: { width: 4032, height: 2268 } } }
    let(:image_holborn_metadata) { { type: 'JPEG', size: 2_203_962, dimensions: { width: 2268, height: 4032 } } }
    let(:image_brighton_metadata) { { type: 'HEIC', size: 2_137_294, dimensions: { width: 4032, height: 3024 } } }

    it 'returns filetype, size, dimensions' do
      expect(image_books.metadata).to eq image_books_metadata
      expect(image_holborn.metadata).to eq image_holborn_metadata
      expect(image_brighton.metadata).to eq image_brighton_metadata
    end
  end
end
