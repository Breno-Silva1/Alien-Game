require 'gosu'

class Cometa
	attr_reader :x, :y, :radius
	def initialize(window)
		@game = window
		@x = 1500
		@y = rand(700)
		@radius = 30
		@images = Gosu::Image.new("media/cometa.png")
	end

	def draw
		@images.draw(@x,@y,4)
	end

	def move
		@x -= 20
	end
end
