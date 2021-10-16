# frozen_string_literal: true

require_relative '../lib/image'

RSpec::Matchers.define :be_resized do |expected|
  match do |actual|
    actual[:width] <= expected || actual[:height] <= expected
  end
end

RSpec.describe Image do
  let(:image_books) { described_class.new('data/books.jpeg') }
  let(:image_holborn) { described_class.new('data/Holborn😄.jpg') }
  let(:image_brighton) { described_class.new('data/Brighton.heic') }
  let(:image_greenwich) { described_class.new('data/Greenwich.PNG') }
  let(:image_bags) { described_class.new('data/home-made&bągs).gif') }
  let(:animation_hogwarts) { described_class.new('data/Hogwarts-animation.gif') }
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
        expect { pdf }.to raise_error(StandardError, 'File format not accepted')
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

  describe '#resize' do
    it 'correctly resizes horizontal jpeg image' do
      filename = image_books.resize

      expect(filename).to match %r{^uploads/resized/(.+)_books.jpeg$}
      expect(File).to exist filename

      expect(described_class.new(filename).dimensions).to be_resized(100)
    end

    it 'correctly resizes vertical jpeg image' do
      filename = image_holborn.resize

      expect(filename).to match %r{^uploads/resized/(.+)_Holborn\u{1F604}.jpg$}
      expect(File).to exist filename

      expect(described_class.new(filename).dimensions).to be_resized(100)
    end

    it 'correctly resizes heic image' do
      filename = image_brighton.resize

      expect(filename).to match %r{^uploads/resized/(.+)_Brighton.heic$}
      expect(File).to exist filename

      expect(described_class.new(filename).dimensions).to be_resized(100)
    end

    it 'correctly resizes png image' do
      filename = image_greenwich.resize

      expect(filename).to match %r{^uploads/resized/(.+)_Greenwich.PNG$}
      expect(File).to exist filename

      expect(described_class.new(filename).dimensions).to be_resized(100)
    end

    it 'correctly resizes gif image' do
      filename = image_bags.resize

      expect(filename).to match %r{^uploads/resized/(.+)_home-made&bągs\).gif$}
      expect(File).to exist filename

      expect(described_class.new(filename).dimensions).to be_resized(100)
    end

    it 'correctly resizes gif animation' do
      filename = animation_hogwarts.resize

      expect(filename).to match %r{^uploads/resized/(.+)_Hogwarts-animation.gif$}
      expect(File).to exist filename

      expect(described_class.new(filename).dimensions).to be_resized(100)
    end
  end

  after(:all) do
    FileUtils.rm_rf('uploads') if Dir.exist?('uploads')
  end
end
