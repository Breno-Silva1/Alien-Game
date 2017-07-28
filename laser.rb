require 'gosu'
require_relative 'jogador'

class Laser
	attr_reader :x, :y, :radius
	def initialize(window,x, y)
		@x = x + 100
		@y = y + 35
		@imagem = Gosu::Image.new("media/laser.png")
		@radius = 20
		@game = window
	end

	def draw
		@imagem.draw(@x, @y, 5)
	end

	def move
		@x += 30
	end
end