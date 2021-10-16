# frozen_string_literal: true

require_relative '../file'

RSpec.describe File do
  subject(:file) { described_class.new(:books_image) }

  let(:books_image) { 'books.jpeg' }

  it 'returns path to the file' do
    expect(file.file_path).to eq(:books_image)
  end
end
