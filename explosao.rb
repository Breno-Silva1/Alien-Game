require 'gosu'

class Explosao
	attr_reader :finished
	def initialize(window, x, y)
		@game = window
		@x = x
		@y = y
		@radius = 30
		@imagem = Gosu::Image.load_tiles("media/explosao.png",128,128)
		@image_idex = 0
		@finished = false
		
	end
	
	def draw
		if @image_idex < @imagem.count
			@imagem[@image_idex].draw(@x - @radius, @y - @radius, 2)
			@image_idex += 1
		else
			@finished = true
			
		end
	end 

end 
	
		
	
