# frozen_string_literal: true

require_relative '../lib/file_handler'

RSpec.describe FileHandler do
  let(:books_file) { described_class.new('data/books.jpeg') }
  let(:holborn_file) { described_class.new('data/Holborn😄.jpg') }
  let(:greenwich) { described_class.new('data/Greenwich.PNG') }
  let(:not_image) { described_class.new('data/pdf/ImageMagick.pdf') }

  it 'returns path to the file' do
    expect(books_file.file_path).to eq('data/books.jpeg')
    expect(holborn_file.file_path).to eq('data/Holborn😄.jpg')
    expect(greenwich.file_path).to eq('data/Greenwich.PNG')
    expect(not_image.file_path).to eq('data/pdf/ImageMagick.pdf')
  end

  context 'when input file does not exist' do
    let(:non_existent_file) { described_class.new('hello.img') }

    it 'raises ArgumentError' do
      expect { non_existent_file }.to raise_error(ArgumentError, 'File does not exist')
    end
  end
end
