require 'gosu'

class Jogador2
	attr_reader :pos_x, :pos_y
	def initialize(window)
		@game = window
		@pos_x = 960
 		@pos_y = 350
 		@imagem = Gosu::Image.new("media/Nave2.png")
 		@imagem_atingido = Gosu::Image.new("media/Nave2_atingida.png")
	end

	def draw
		@imagem.draw(@pos_x,@pos_y,6)
	end

	def draw_atingido()
		@imagem_atingido.draw(@pos_x,@pos_y,6)
	end

	def mover_direita
	 	@pos_x = @pos_x + 10
	 	if (@pos_x > 1040 ) then
	 		@pos_x = 1040
	 	end
	end
	def mover_esquerda
		@pos_x = @pos_x - 10
	 	if (@pos_x < 650) then @pos_x = 650 end
	end

	def mover_baixo
		 @pos_y = @pos_y + 10
		 if (@pos_y > 680 ) then
			 @pos_y = 680
		 end
	end

	def mover_cima
	 	@pos_y = @pos_y - 10
	 	if (@pos_y < 10) then @pos_y = 10 end
	end
end 
