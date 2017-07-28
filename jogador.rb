require 'gosu'

class Jogador
	attr_reader :pos_x, :pos_y
	def initialize(window)
		@game = window
		@pos_x = 50
 		@pos_y = 350
 		@imagem = Gosu::Image.new("media/Nave.png")
 		@imagem_atingido = Gosu::Image.new("media/Nave_atingida.png")
	end

	def draw
		@imagem.draw(@pos_x,@pos_y,6)
	end

	def draw_atingido()
		@imagem_atingido.draw(@pos_x,@pos_y,7)
	end

	def mover_direita
	 	@pos_x = @pos_x + 10
	 	if (@pos_x > 800 ) then
	 		@pos_x = 800
	 	end
	end
	def mover_direita_batalha
	 	@pos_x = @pos_x + 10
	 	if (@pos_x > 400 ) then
	 		@pos_x = 400
	 	end
	end
	def mover_esquerda
		@pos_x = @pos_x - 10
	 	if (@pos_x < 10) then @pos_x = 10 end
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
