# frozen_string_literal: true

require_relative '../file'

RSpec.describe File do
  let(:books_file) { described_class.new('data/books.jpeg') }
  let(:holborn_file) { described_class.new('data/Holborn.jpg') }
  let(:greenwich) { described_class.new('data/Greenwich.PNG') }
  let(:not_image) { described_class.new('data/pdf/ImageMagick.pdf') }

  it 'returns path to the file' do
    expect(books_file.file_path).to eq('data/books.jpeg')
    expect(holborn_file.file_path).to eq('data/Holborn.jpg')
    expect(greenwich.file_path).to eq('data/Greenwich.PNG')
    expect(not_image.file_path).to eq('data/pdf/ImageMagick.pdf')
  end

  describe '#valid_path?' do
    context 'when input file does exist' do
      it 'returns true' do
        expect(books_file.valid_path?).to eq true
        expect(holborn_file.valid_path?).to eq true
        expect(greenwich.valid_path?).to eq true
        expect(not_image.valid_path?).to eq true
      end
    end

    context 'when input file does not exist' do
      subject(:file) { described_class.new('hello.img') }

      it 'returns false' do
        expect(file.valid_path?).to eq false
      end
    end
  end

  describe '#extension' do
    it 'returns downcased file extension' do
      expect(books_file.extension).to eq '.jpeg'
      expect(holborn_file.extension).to eq '.jpg'
      expect(greenwich.extension).to eq '.png'
      expect(not_image.extension).to eq '.pdf'
    end
  end
end
