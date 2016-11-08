# Main program controller
class BitmapEditor
  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      command, *arguments = input.split(' ')
      execute_command(command, arguments)
    end
  end

  def execute_command(command, arguments)
    case command
    when '?'
      show_help

    when 'C'
      clear

    when 'L'
      pixel arguments

    when 'V'
      vertical arguments

    when 'H'
      horizontal arguments

    when 'I'
      init arguments

    when 'S'
      show

    when 'X'
      exit_console

    else
      output 'unrecognised command :('
    end
  rescue NoMethodError
    output 'must init an image first' unless @image
  end

  private

  def output(message)
    return unless @running
    puts message
  end

  def clear
    width = @image.width
    height = @image.height
    @image = Bitmap.new(width, height)
  end

  def pixel(arguments)
    x = arguments[0].to_i
    y = arguments[1].to_i
    colour = arguments[2]
    @image.set_pixel(x, y, colour)
    output_errors
  end

  def vertical(arguments)
    x = arguments[0].to_i
    y1 = arguments[1].to_i
    y2 = arguments[2].to_i
    colour = arguments[3]
    @image.set_vertical_segment(x, y1, y2, colour)
    output_errors
  end

  def horizontal(arguments)
    x1 = arguments[0].to_i
    x2 = arguments[1].to_i
    y = arguments[2].to_i
    colour = arguments[3]
    @image.set_horizontal_segment(x1, x2, y, colour)
    output_errors
  end

  def init(arguments)
    width = arguments.first.to_i
    height = arguments.last.to_i
    @image = Bitmap.new(width, height)
  end

  def show
    output @image.contents
  end

  def output_errors
    output @image.errors.join("\n") if @image.errors.any?
  end

  def exit_console
    output 'goodbye!'
    @running = false
  end

  def show_help
    output "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
  end
end
