# bitmap_editor

An example bitmap manipulation to that implements 8 simple commands to manipulate bitmap images.

* I M N - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current image
* ? - Displays help text
* X - Terminate the session

To run the program just run runner.rb

To run the tests just run rspec in the route folder

The application is mainly structured as follows:
* BitmapEditor - basic controller class that parses commands
* Bitmap - basic model class that stores/manipulates state of image

Coordinates start at 1,1 being the top left

Maximum width or height is 250 pixels

I have not added it as a dependancy, but have used rubocop and followed most of its reccomendations.


