# frozen_string_literal: true

require_relative '../image'

RSpec.describe Image do
  let(:image_books) { described_class.new('data/books.jpeg') }
  let(:image_holborn) { described_class.new('data/Holborn.jpg') }
  let(:image_brighton) { described_class.new('data/Brighton.heic') }
  let(:pdf) { described_class.new('data/pdf/ImageMagick.pdf') }
  let(:txt) { described_class.new('data/text/file.txt') }

  context 'when input file is a recognised image' do
    it 'successfully creates object' do
      expect(image_books).to be_a Image
      expect(image_holborn).to be_a Image
      expect(image_brighton).to be_a Image
    end

    context 'when input file does not have the app accepted format' do
      it 'raises exception' do
        expect { pdf }.to raise_error(StandardError)
      end
    end
  end

  context 'when input file is not a recognised image' do
    it 'raises exception' do
      expect { txt }.to raise_error(MiniMagick::Invalid)
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
