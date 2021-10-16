# frozen_string_literal: true

require_relative '../image'

RSpec.describe Image do
  let(:image_books) { described_class.new('data/books.jpeg') }
  let(:image_holborn) { described_class.new('data/Holborn.jpg') }
  let(:image_brighton) { described_class.new('data/Brighton.heic') }
  let(:pdf) { described_class.new('data/pdf/ImageMagick.pdf') }
  let(:txt) { described_class.new('data/text/file.txt') }

  describe '#image?' do
    context 'when input file is an image' do
      it 'returns true' do
        expect(image_books.image?).to eq true
        expect(image_holborn.image?).to eq true
        expect(image_brighton.image?).to eq true
      end
    end

    context 'when input file is not an image' do
      it 'returns false' do
        expect { pdf.image? }.to raise_error(StandardError)
        expect { txt.image? }.to raise_error(MiniMagick::Invalid)
      end
    end
  end
end
