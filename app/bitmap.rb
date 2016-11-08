# Bitmap model
class Bitmap
  WHITE = 'O'
  MAX_SIZE = 250

  attr_reader :errors

  def initialize(width, height)
    @errors = []
    check_width(width)
    check_height(height)
    height = 1 unless height >= 1 && height <= MAX_SIZE
    width = 1 unless width >= 1 && width <= MAX_SIZE
    @structure = Array.new(height) { Array.new(width, WHITE) }
  end

  def set_pixel(x, y, colour)
    @errors = []
    check_x_position(x)
    check_y_position(y)
    check_colour(colour)
    return if errors.any?
    @structure[y - 1][x - 1] = colour
  end

  def set_vertical_segment(x, y1, y2, colour)
    check_x_position(x)
    check_y_position(y1, 'Y1')
    check_y_position(y2, 'Y2')
    check_colour(colour)
    @errors << 'Y2 must be higher than Y1' unless y2 > y1
    return if errors.any?
    y1.upto(y2) do |y|
      @structure[y - 1][x - 1] = colour
    end
  end

  def set_horizontal_segment(x1, x2, y, colour)
    check_x_position(x1, 'X1')
    check_x_position(x2, 'X2')
    check_y_position(y)
    check_colour(colour)
    @errors << 'X2 must be higher than X1' unless x2 > x1
    return if errors.any?
    x1.upto(x2) do |x|
      @structure[y - 1][x - 1] = colour
    end
  end

  def width
    @structure.first.size
  end

  def height
    @structure.size
  end

  def contents
    rows = @structure.map(&:join)
    rows.join("\n")
  end

  private

  def check_height(height)
    @errors << 'height too low' if height < 1
    @errors << 'height too high' if height > MAX_SIZE
  end

  def check_width(width)
    @errors << 'width too low' if width < 1
    @errors << 'width too high' if width > MAX_SIZE
  end

  def check_x_position(x, name = 'X')
    @errors << "#{name} position too low" unless x >= 1
    @errors << "#{name} position too high" unless x <= width
  end

  def check_y_position(y, name = 'Y')
    @errors << "#{name} position too low" unless y >= 1
    @errors << "#{name} position too high" unless y <= height
  end

  def check_colour(colour)
    @errors << 'Unknown colour' unless ('A'..'Z').include? colour
  end
end
