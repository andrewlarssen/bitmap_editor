class BitmapEditor

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '
      input = gets.chomp
      command, *arguments = input.split(' ')
      case command
        when '?'
          show_help

        when 'C'
          puts 'NOT IMPLEMENTED'

        when 'L'
          puts 'NOT IMPLEMENTED'

        when 'V'
          puts 'NOT IMPLEMENTED'

        when 'H'
          puts 'NOT IMPLEMENTED'

        when 'I'
          width = arguments.first.to_i
          height = arguments.last.to_i
          @image = Bitmap.new(width, height)

        when 'S'
          puts @image.contents

        when 'X'
          exit_console

        else
          puts 'unrecognised command :('
      end
    end
  end

  private
    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
    end
end
