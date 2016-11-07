require 'spec_helper'
require './app/bitmap'

RSpec.describe Bitmap do

  let(:image) { Bitmap.new(4, 5) }

  describe '.new' do
    it 'creates an image with the correct dimensions and all white pixels' do
      expect(image.contents).to eq "OOOO\nOOOO\nOOOO\nOOOO\nOOOO"
    end
  end
end
