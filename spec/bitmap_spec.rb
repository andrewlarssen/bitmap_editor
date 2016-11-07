require 'spec_helper'
require './app/bitmap'

RSpec::Matchers.define :have_the_default_contents do
  match do |actual|
    actual.contents == "OOOO\nOOOO\nOOOO\nOOOO\nOOOO"
  end
end

RSpec.describe Bitmap do
  let(:image) { Bitmap.new(4, 5) }

  describe '.new' do
    it 'creates an image with the correct dimensions and all white pixels' do
      expect(image).to have_the_default_contents
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

    it 'sets an error if the x position is to high' do
      image.set_pixel(5, 3, 'A')
      expect(image.errors).to eq ['X position to high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x position is to low' do
      image.set_pixel(0, 3, 'A')
      expect(image.errors).to eq ['X position to low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y position is to high' do
      image.set_pixel(1, 6, 'A')
      expect(image.errors).to eq ['Y position to high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y position is to low' do
      image.set_pixel(1, 0, 'A')
      expect(image.errors).to eq ['Y position to low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the colour is invalid' do
      image.set_pixel(1, 1, 'n')
      expect(image.errors).to eq ['Unknown colour']
      expect(image).to have_the_default_contents
    end
  end

  describe '#set_vertical_segment' do
    it 'sets a vertical segment to the correct colour' do
      image.set_vertical_segment(2, 2, 5, 'A')
      expect(image.contents).to eq "OOOO\nOAOO\nOAOO\nOAOO\nOAOO"
    end

    it 'sets an error if the x position is to high' do
      image.set_vertical_segment(5, 2, 5, 'A')
      expect(image.errors).to eq ['X position to high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x position is to low' do
      image.set_vertical_segment(0, 2, 5, 'A')
      expect(image.errors).to eq ['X position to low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y1 position is to high' do
      image.set_vertical_segment(2, 6, 5, 'A')
      expect(image.errors).to include('Y1 position to high')
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y1 position is to low' do
      image.set_vertical_segment(2, 0, 5, 'A')
      expect(image.errors).to eq ['Y1 position to low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y2 position is to high' do
      image.set_vertical_segment(2, 2, 6, 'A')
      expect(image.errors).to eq ['Y2 position to high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y2 position is to low' do
      image.set_vertical_segment(2, 2, 0, 'A')
      expect(image.errors).to include('Y2 position to low')
      expect(image).to have_the_default_contents
    end

    it 'sets an error if y2 > y1' do
      image.set_vertical_segment(2, 3, 2, 'A')
      expect(image.errors).to eq ['Y2 must be higher than Y1']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the colour is invalid' do
      image.set_vertical_segment(2, 2, 5, 'n')
      expect(image.errors).to eq ['Unknown colour']
      expect(image).to have_the_default_contents
    end
  end
end
