require 'gosu'

class Satelite
	attr_reader :x, :y
	def initialize(window)
		@game = window
		@x = 1500
		@y = rand(700)
		@images = Gosu::Image.load_tiles(@game, "media/satelite.png",200,112, false)
		@current_frame = @images[0]
	end

	def draw
		@current_frame.draw(@x,@y,2)
		@current_frame = @images[Gosu::milliseconds / 250 % @images.size]
	end
	
	def move
		@x -= 10
	end
end
