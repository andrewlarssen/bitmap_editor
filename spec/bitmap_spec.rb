require 'spec_helper'
require './app/bitmap'

RSpec.describe Bitmap do

  let(:image) { Bitmap.new(4, 5) }

  describe '.new' do
    it 'creates an image with the correct dimensions and all white pixels' do
      expect(image.contents).to eq "OOOO\nOOOO\nOOOO\nOOOO\nOOOO"
    end
  end

  describe '#width' do
    it 'returns the image width' do
      expect(image.width).to eq 4
    end
  end

  describe '#height' do
    it 'returns the image height' do
      expect(image.height).to eq 5
    end
  end

  describe '#set_pixel' do
    it 'sets a single pixel to the correct colour' do
      image.set_pixel(3, 1, 'A')
      expect(image.contents).to eq "OOAO\nOOOO\nOOOO\nOOOO\nOOOO"
    end
  end
end
