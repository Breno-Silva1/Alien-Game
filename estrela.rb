require 'gosu'

class Estrela
	attr_reader :x, :y
	def initialize(window)
		@game = window
		@x = rand(1500)
		@y = 0
		@star = Gosu::Image.load_tiles(@game, "media/star.png",36,36, false)
		@current_frame = @star[0]
	end

	def draw
		@current_frame.draw(@x,@y,1)
		@current_frame = @star[Gosu::milliseconds / 800 % @star.size]
	end
	
	def move
		@y += 8
	end
end
