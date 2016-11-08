require 'spec_helper'
require './app/bitmap_editor'

RSpec.describe BitmapEditor do
  let(:bitmap_editor) { described_class.new }
  describe '#execute_command' do
    context 'I - Initialize' do
      it 'passes the correct arguments to the model' do
        expect(Bitmap).to receive(:new).with(10, 10)
        bitmap_editor.execute_command('I', ['10', '10'])
      end
    end

    context 'C - Clear' do
      it 're-initializes the image with the sam dimensions as the current image' do
        image = instance_double(Bitmap)
        expect(image).to receive(:height).and_return(10)
        expect(image).to receive(:width).and_return(10)
        bitmap_editor.instance_variable_set '@image', image
        expect(Bitmap).to receive(:new).with(10, 10)
        bitmap_editor.execute_command('C', [])
      end
    end

    context 'L - Set pixel' do
      it 'calls the set_pixel method on the model with the correct arguments' do
        image = instance_double(Bitmap)
        expect(image).to receive(:set_pixel).with(1, 2, 'A')
        expect(image).to receive(:errors).and_return([])
        bitmap_editor.instance_variable_set '@image', image
        bitmap_editor.execute_command('L', ['1', '2', 'A'])
      end
    end

    context 'V - Set vertical section' do
      it 'calls the set_vertical_segment method on the model with the correct arguments' do
        image = instance_double(Bitmap)
        expect(image).to receive(:set_vertical_segment).with(1, 2, 3, 'A')
        expect(image).to receive(:errors).and_return([])
        bitmap_editor.instance_variable_set '@image', image
        bitmap_editor.execute_command('V', ['1', '2', '3', 'A'])
      end
    end

    context 'H - Set horizontal section' do
      it 'calls the set_horizontal_segment method on the model with the correct arguments' do
        image = instance_double(Bitmap)
        expect(image).to receive(:set_horizontal_segment).with(1, 2, 3, 'A')
        expect(image).to receive(:errors).and_return([])
        bitmap_editor.instance_variable_set '@image', image
        bitmap_editor.execute_command('H', ['1', '2', '3', 'A'])
      end
    end

    context 'S - Show' do
      it 'calls the show method on the model' do
        image = instance_double(Bitmap)
        expect(image).to receive(:contents)
        bitmap_editor.instance_variable_set '@image', image
        bitmap_editor.execute_command('S', [])
      end
    end
  end
end
