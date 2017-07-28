require 'gosu'

class Estrela
	attr_reader :x, :y
	def initialize(window)
		@game = window
		@x = rand(960)
		@y = 0
		@x2 = rand(600)
		@y2 = 0
		@star_green = Gosu::Image.load_tiles(@game, "media/star_green.png",36,36, false)
		@current_frame = @star_green[0]
	end

	def draw
		@current_frame.draw(@x,@y,3)
		@current_frame = @star_green[Gosu::milliseconds / 50 % @star_green.size]
	end
	
	def move
		@y += 10
	end
end
