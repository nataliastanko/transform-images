# frozen_string_literal: true

require_relative '../file'

RSpec.describe File do
  subject(:file) { described_class.new(input_file) }

  let(:input_file) { 'data/books.jpeg' }

  it 'returns path to the file' do
    expect(file.file_path).to eq(input_file)
  end

  describe '#valid_path?' do
    context 'when input file does exist' do
      it 'returns true' do
        expect(file.valid_path?).to eq true
      end
    end

    context 'when input file does not exist' do
      let(:input_file) { 'hello.img' }

      it 'returns false' do
        expect(file.valid_path?).to eq false
      end
    end
  end
end
