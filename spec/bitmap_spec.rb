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

    it 'creates an image with an error if the width is too low' do
      image = Bitmap.new(0, 5)
      expect(image.errors).to eq ['width too low']
      expect(image.width).to eq 1
    end

    it 'creates an image with an error if the width is too high' do
      image = Bitmap.new(251, 5)
      expect(image.errors).to eq ['width too high']
      expect(image.width).to eq 1
    end

    it 'creates an image with an error if the height is too low' do
      image = Bitmap.new(4, 0)
      expect(image.errors).to eq ['height too low']
      expect(image.height).to eq 1
    end

    it 'creates an image with an error if the height is too high' do
      image = Bitmap.new(4, 251)
      expect(image.errors).to eq ['height too high']
      expect(image.height).to eq 1
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

    it 'sets an error if the x position is too high' do
      image.set_pixel(5, 3, 'A')
      expect(image.errors).to eq ['X position too high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x position is too low' do
      image.set_pixel(0, 3, 'A')
      expect(image.errors).to eq ['X position too low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y position is too high' do
      image.set_pixel(1, 6, 'A')
      expect(image.errors).to eq ['Y position too high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y position is too low' do
      image.set_pixel(1, 0, 'A')
      expect(image.errors).to eq ['Y position too low']
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

    it 'sets an error if the x position is too high' do
      image.set_vertical_segment(5, 2, 5, 'A')
      expect(image.errors).to eq ['X position too high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x position is too low' do
      image.set_vertical_segment(0, 2, 5, 'A')
      expect(image.errors).to eq ['X position too low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y1 position is too high' do
      image.set_vertical_segment(2, 6, 5, 'A')
      expect(image.errors).to include('Y1 position too high')
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y1 position is too low' do
      image.set_vertical_segment(2, 0, 5, 'A')
      expect(image.errors).to eq ['Y1 position too low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y2 position is too high' do
      image.set_vertical_segment(2, 2, 6, 'A')
      expect(image.errors).to eq ['Y2 position too high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y2 position is too low' do
      image.set_vertical_segment(2, 2, 0, 'A')
      expect(image.errors).to include('Y2 position too low')
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

  describe '#set_horizontal_segment' do
    it 'sets a horizontal segment to the correct colour' do
      image.set_horizontal_segment(2, 4, 5, 'A')
      expect(image.contents).to eq "OOOO\nOOOO\nOOOO\nOOOO\nOAAA"
    end

    it 'sets an error if the x1 position is too high' do
      image.set_horizontal_segment(5, 4, 5, 'A')
      expect(image.errors).to include('X1 position too high')
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x1 position is too low' do
      image.set_horizontal_segment(0, 4, 5, 'A')
      expect(image.errors).to eq ['X1 position too low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x2 position is too high' do
      image.set_horizontal_segment(2, 5, 5, 'A')
      expect(image.errors).to eq ['X2 position too high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the x2 position is too low' do
      image.set_horizontal_segment(2, 0, 5, 'A')
      expect(image.errors).to include('X2 position too low')
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y position is too high' do
      image.set_horizontal_segment(2, 4, 6, 'A')
      expect(image.errors).to eq ['Y position too high']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the y position is too low' do
      image.set_horizontal_segment(2, 4, 0, 'A')
      expect(image.errors).to eq ['Y position too low']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if x2 > x1' do
      image.set_horizontal_segment(4, 3, 3, 'A')
      expect(image.errors).to eq ['X2 must be higher than X1']
      expect(image).to have_the_default_contents
    end

    it 'sets an error if the colour is invalid' do
      image.set_horizontal_segment(2, 4, 5, 'n')
      expect(image.errors).to eq ['Unknown colour']
      expect(image).to have_the_default_contents
    end
  end
end
