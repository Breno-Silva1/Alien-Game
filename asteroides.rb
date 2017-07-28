require 'gosu'

class Asteroides
	attr_reader :x, :y, :radius
	def initialize(window)
		@game = window
		@x = 1500
		@y = rand(700)
		@radius = 30
		@images = Gosu::Image.load_tiles(@game, "media/asteroides.png",79,76, false)
		@current_frame = @images[0]
	end

	def draw
		@current_frame.draw(@x,@y,4)
		@current_frame = @images[Gosu::milliseconds / 500 % @images.size]
	end

	def move
		@x -= 7
	end
end
