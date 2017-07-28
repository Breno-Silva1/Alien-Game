puts "Carregando..."
$LOAD_PATH << '.'

require 'gosu'
require_relative 'jogador'
require_relative 'jogador2'
require_relative 'asteroides'
require_relative 'satelite'
require_relative 'laser'
require_relative 'laser2'
require_relative 'explosao'
require_relative 'estrela'
require_relative 'cometa'

class AlienGame < Gosu::Window

  #CONSTANTES
	ASTEROIDES = 0.04
  SATELITE = 0.001
  ESTRELA = 0.09
  COMETA = 0.009
	
	def initialize
		super(1280,960, false)
		self.caption = "Alien Game"

 		@option = 1
 		@estado = :title
		@image_index = 0
    @scroll_x = 0
    @scroll_x_lua = 0
    @pontuacao = 0
    @record = @pontuacao
    @vida_nave1 = 100
    @vida_nave2 = 100
    @atingido1 = false
    @atingido2 = false
    #TIME
    @seg = 0.0
    @min = 0.0
	
		#IMAGENS
		@background_image = Gosu::Image.new("media/bg2.png")
    @chao = Gosu::Image.new("media/chao.png", :tileable => false)
    @chao_batalha = Gosu::Image.new("media/chao_batalha.png")
    @lua = Gosu::Image.new("media/lua.png", :tileable => false)
		@bg_option1 = Gosu::Image.new("media/opc1.png")
	  @bg_option2 = Gosu::Image.new("media/opc2.png")
   	@bg_option3 = Gosu::Image.new("media/opc3.png")
    @bg_option4 = Gosu::Image.new("media/opc4.png")
	  @instrucoes = Gosu::Image.new("media/Instrucoes.png")
    @instrucoes_batalha = Gosu::Image.new("media/Instrucoes_batalha.png")
    @gameover = Gosu::Image.new("media/gameover.png")
    @winner1 = Gosu::Image.new("media/winner1.png")
    @winner2 = Gosu::Image.new("media/winner2.png")
      #Barra de Porcentagem - Nave 1
      @barra_100 = Gosu::Image.new("media/barra/nave1/100%.png")
      @barra_90 = Gosu::Image.new("media/barra/nave1/90%.png")
      @barra_80 = Gosu::Image.new("media/barra/nave1/80%.png")
      @barra_70 = Gosu::Image.new("media/barra/nave1/70%.png")
      @barra_60 = Gosu::Image.new("media/barra/nave1/60%.png")
      @barra_50 = Gosu::Image.new("media/barra/nave1/50%.png")
      @barra_40 = Gosu::Image.new("media/barra/nave1/40%.png")
      @barra_30 = Gosu::Image.new("media/barra/nave1/30%.png")
      @barra_20 = Gosu::Image.new("media/barra/nave1/20%.png")
      @barra_10 = Gosu::Image.new("media/barra/nave1/10%.png")
      #Barra de Porcentagem - Nave 2
      @barra_100_2 = Gosu::Image.new("media/barra/nave2/100%.png")
      @barra_90_2 = Gosu::Image.new("media/barra/nave2/90%.png")
      @barra_80_2 = Gosu::Image.new("media/barra/nave2/80%.png")
      @barra_70_2 = Gosu::Image.new("media/barra/nave2/70%.png")
      @barra_60_2 = Gosu::Image.new("media/barra/nave2/60%.png")
      @barra_50_2 = Gosu::Image.new("media/barra/nave2/50%.png")
      @barra_40_2 = Gosu::Image.new("media/barra/nave2/40%.png")
      @barra_30_2 = Gosu::Image.new("media/barra/nave2/30%.png")
      @barra_20_2 = Gosu::Image.new("media/barra/nave2/20%.png")
      @barra_10_2 = Gosu::Image.new("media/barra/nave2/10%.png")
    
    #SONS
	  @game_song = Gosu::Song.new("media/audio/game.ogg")
    @menu_song = Gosu::Song.new("media/audio/menu.ogg")
    @over_song = Gosu::Song.new("media/audio/over.ogg")
    @batalha_song = Gosu::Song.new("media/audio/batalha.ogg")
    @win_song = Gosu::Song.new("media/audio/win.ogg")
    @laser_song = Gosu::Sample.new("media/audio/laser.ogg")
    @dano_song = Gosu::Sample.new("media/audio/dano.ogg")
    @opc_song = Gosu::Sample.new("media/audio/opc.ogg")

    #FONTES
    @font = Gosu::Font.new(self, "Arial", 30)
    @font_maior = Gosu::Font.new(self, "Arial", 50)

    #OBJETOS
    @jogador = Jogador.new(self)
    @jogador2 = Jogador2.new(self)
		
    #ARRAY DE IMAGENS
    @estrela = []
    @asteroide = []
    @satelite = []
    @laser = []
    @laser2 = []
    @explosao = []
    @cometa = []
	  
    #CRÉDITOS: MOVIMENTO DO "TCHAU" DO ALIEN
    @creditos = []
    for i in 0..20 do @creditos[i] = Gosu::Image.new("media/creditos.png") end
    for i in 21..40 do @creditos[i] = Gosu::Image.new("media/creditos2.png") end
    for i in 41..60 do @creditos[i] = Gosu::Image.new("media/creditos.png") end
    for i in 61..80 do @creditos[i] = Gosu::Image.new("media/creditos2.png") end
    for i in 81..100 do @creditos[i] = Gosu::Image.new("media/creditos.png") end
    for i in 101..120 do @creditos[i] = Gosu::Image.new("media/creditos2.png") end	   
	end
#Draw
	def draw
		case @estado
		when :title
	    @bg_option1.draw(0, 0, 0) if @option == 1
	    @bg_option2.draw(0, 0, 0) if @option == 2
	    @bg_option3.draw(0, 0, 0) if @option == 3
      @bg_option4.draw(0, 0, 0) if @option == 4
   	when :game
      @seg += 1.0/60.0

      if @seg.to_i == 60
        @min += 1
        @seg = 0 
      end

      @font.draw("Pontos: #{@pontuacao}", 50,30,8,1.0,1.0,0xffffffff)
      @font.draw("Tempo: #{@min.to_i}:#{@seg.to_i}", 50,70,8,1.0,1.0,0xffffffff)
	    @background_image.draw(0, 0, 0)
      #CHÃO
      @chao.draw(-@scroll_x,780, 2)
      @chao.draw(-@scroll_x + @background_image.width, 780, 2)
      #LUA
      @lua.draw(-@scroll_x_lua,360, 1)
      @lua.draw(-@scroll_x_lua + (@background_image.width * 2), 360, 1)
	    @jogador.draw

	    @asteroide.each do |asteroide| asteroide.draw end
      @satelite.each do |satelite| satelite.draw end
      @cometa.each do |cometa| cometa.draw end
      @explosao.each do |explosao| explosao.draw end 
      @laser.each do |laser| laser.draw end 

    when :game_batalha
      @background_image.draw(0, 0, 0)
      @chao_batalha.draw(0,780, 2)
      @estrela.each do |estrela| estrela.draw end
      @laser.each do |laser| laser.draw end 
      @laser2.each do |laser2| laser2.draw end 
      if @atingido1 == false
        @jogador.draw
      else
        @jogador.draw_atingido()
        @atingido1 = false
      end

      if @atingido2 == false
        @jogador2.draw
      else 
        @jogador2.draw_atingido()
        @atingido2 = false
      end
        
      
      @font.draw("Vida Nave 1:", 50,30,8,1.0,1.0,0xffffffff)
      @font_maior.draw("#{@vida_nave1}", 220,15,8,1.0,1.0,0xf00fff00)

      @font.draw("Vida Nave 2:", 955,30,8,1.0,1.0,0xffffffff)
      @font_maior.draw("#{@vida_nave2}", 1125,15,8,1.0,1.0,0xffff00ff)

      if @vida_nave1 == 100 
        @barra_100.draw(50,80,8)
      elsif @vida_nave1 == 90 
        @barra_90.draw(50,80,8)
      elsif @vida_nave1 == 80 
        @barra_80.draw(50,80,8)
      elsif @vida_nave1 == 70 
        @barra_70.draw(50,80,8)
      elsif @vida_nave1 == 60 
        @barra_60.draw(50,80,8)
      elsif @vida_nave1 == 50 
        @barra_50.draw(50,80,8)
      elsif @vida_nave1 == 40 
        @barra_40.draw(50,80,8) 
      elsif @vida_nave1 == 30 
        @barra_30.draw(50,80,8)
      elsif @vida_nave1 == 20 
        @barra_20.draw(50,80,8)
      elsif @vida_nave1 == 10 
        @barra_10.draw(50,80,8)
      end
      if @vida_nave2 == 100 
        @barra_100_2.draw(900,80,8)
      elsif @vida_nave2 == 90 
        @barra_90_2.draw(900,80,8)
      elsif @vida_nave2 == 80 
        @barra_80_2.draw(900,80,8)
      elsif @vida_nave2 == 70 
        @barra_70_2.draw(900,80,8)
      elsif @vida_nave2 == 60 
        @barra_60_2.draw(900,80,8)
      elsif @vida_nave2 == 50 
        @barra_50_2.draw(900,80,8)
      elsif @vida_nave2 == 40 
        @barra_40_2.draw(900,80,8) 
      elsif @vida_nave2 == 30 
        @barra_30_2.draw(900,80,8)
      elsif @vida_nave2 == 20 
        @barra_20_2.draw(900,80,8)
      elsif @vida_nave2 == 10 
        @barra_10_2.draw(900,80,8)
      end
    when :winner
      if (@vida_nave1 == 0 and @vida_nave2 != 0) then
        @winner2.draw(0,0,0)
      elsif (@vida_nave2 == 0 and @vida_nave1 != 0) then
        @winner1.draw(0,0,0)
      else  
        @font.draw("Empate!", 500,500,8,1.0,1.0,0xffffffff)
	    end
	  when :credits
  		if @image_index < @creditos.count
  		  @creditos[@image_index].draw(0, 0, 0)
  		  @image_index += 1
  		else
  		@image_index = 0
  		end
    when :tutorial
      @instrucoes.draw(0, 0, 0) 
    when :tutorial_batalha
      @instrucoes_batalha.draw(0,0,0)
    when :over
      tempo = "#{@min.to_i}min e #{@seg.to_i}s"
      @gameover.draw(0,0,7)
      @font_maior.draw("#{@pontuacao}", 1060,475,7,1.0,1.0,0xf00fff00)
      @font_maior.draw("#{tempo}", 980,590,7,1.0,1.0,0xf00fff00)
      @font_maior.draw("#{@record}", 830,802,7,1.0,1.0,0xf00fff00)
    end
	end

	def update
    case @estado
    when :title
      @menu_song.play(true)
      @game_song.stop
      @over_song.stop
      @batalha_song.stop
      @scroll_x = 0
    when :game
     @game_song.play(true)
     @menu_song.stop
     @over_song.stop
     @batalha_song.stop

     #MOVIMENTOS DO JOGADOR
		 if ( button_down?(Gosu::Button::KbRight) ) then
		 	@jogador.mover_direita
		 end
		 if ( button_down?(Gosu::Button::KbLeft) ) then
			@jogador.mover_esquerda
		 end
		 if ( button_down?(Gosu::Button::KbDown) ) then
			 @jogador.mover_baixo
		 end
		 if ( button_down?(Gosu::Button::KbUp) ) then
		 	@jogador.mover_cima
		 end
    
    #MOVIMENTOS DO ASTEROIDE 
		if rand < ASTEROIDES then 
		    @asteroide.push Asteroides.new(self) 
		end
		@asteroide.each do |asteroide| asteroide.move end

    #MOVIMENTOS DAS SATELITE
    if rand < SATELITE then 
      @satelite.push Satelite.new(self)
    end 
    @satelite.each do |satelite| satelite.move end

    #MOVIMENTOS DOS COMETAS
    if (@pontuacao >= 100) then
      if rand < COMETA then 
        @cometa.push Cometa.new(self) 
      end 
      @cometa.each do |cometa| cometa.move end
    end
    #MOVIMENTO DO CHÃO
    @scroll_x += 3
      if @scroll_x > @background_image.width
        @scroll_x = 0
    end

    #MOVIMENTO DA LUA
    @scroll_x_lua += 2
      if @scroll_x_lua > (@background_image.width * 2)
        @scroll_x_lua = 0
    end

    @laser.each do |laser| laser.move end

    #Condição para colisões entre dois objetos
    @asteroide.dup.each do |asteroide|
      @laser.dup.each do |laser|
        distancia = Gosu::distance(asteroide.x, asteroide.y, laser.x, laser.y)
        if distancia < asteroide.radius + laser.radius then
          @asteroide.delete asteroide
          @laser.delete laser
          @explosao.push Explosao.new(self, asteroide.x, asteroide.y)
          @pontuacao += 10
          if @pontuacao > @record then
            @record = @pontuacao
          end
        end
      end
    end

    @asteroide.each do |asteroide|
      if (Gosu::distance(@jogador.pos_x,@jogador.pos_y,asteroide.x-10,asteroide.y-10)) < 90 then
        @estado = :over
      end 
    end

    @cometa.each do |cometa|
      if (Gosu::distance(@jogador.pos_x,@jogador.pos_y,cometa.x,cometa.y)) < 90 then
        @estado = :over
      end 
    end

    @laser.dup.each do |laser|
      if laser.x > 1280 - 50 then 
        @laser.delete laser
      end 
    end
    
    @explosao.dup.each do |explosao|
      @explosao.delete explosao if explosao.finished
    end
    #Game_Batalha
    when :game_batalha
      @batalha_song.play(true)
      @game_song.stop
      @menu_song.stop
      @over_song.stop
     if ( button_down?(Gosu::Button::KbRight) ) then
      @jogador2.mover_direita
     end
     if ( button_down?(Gosu::Button::KbLeft) ) then
      @jogador2.mover_esquerda
     end
     if ( button_down?(Gosu::Button::KbDown) ) then
       @jogador2.mover_baixo
     end
     if ( button_down?(Gosu::Button::KbUp) ) then
      @jogador2.mover_cima
     end

     if ( button_down?(Gosu::Button::KbD) ) then
      @jogador.mover_direita_batalha
     end
     if ( button_down?(Gosu::Button::KbA) ) then
      @jogador.mover_esquerda
     end
     if ( button_down?(Gosu::Button::KbS) ) then
       @jogador.mover_baixo
     end
     if ( button_down?(Gosu::Button::KbW) ) then
      @jogador.mover_cima
     end

    @scroll_x += 3
      if @scroll_x > @background_image.width
        @scroll_x = 0
    end

    #MOVIMENTOS DAS ESTRELA
    if rand < ESTRELA then 
      @estrela.push Estrela.new(self)
    end 
    @estrela.each do |estrela| estrela.move end

    @laser.each do |laser| laser.move end
    @laser2.each do |laser2| laser2.move end
 
    #Condição para colisões entre laser/nave 2
    @laser.each do |laser|
      if (Gosu::distance(@jogador2.pos_x,@jogador2.pos_y,laser.x,laser.y)) < 90 then
        @atingido2 = true
        @dano_song.play
	      @laser.delete laser
        @vida_nave2-= 10
      end 
    end
  	if (@vida_nave2 == 0) then 
  	@estado = :winner
  	end
    #Condição para colisões entre laser/nave 1
    @laser2.each do |laser2|
      if (Gosu::distance(@jogador.pos_x,@jogador.pos_y,laser2.x,laser2.y)) < 90 then
        @atingido1 = true
        @dano_song.play
	      @laser2.delete laser2
        @vida_nave1-= 10
      end 
    end
  	if (@vida_nave1 == 0) then 
  	   @estado = :winner
  	end

    @laser.dup.each do |laser|
      if laser.x > 1280 - 50 then 
        @laser.delete laser
      end 
    end
    
    @explosao.dup.each do |explosao|
      @explosao.delete explosao if explosao.finished
    end
    #fim
    @laser.dup.each do |laser|
      if laser.x > 1280 - 50 then 
        @laser.delete laser
      end 
    end

    @laser2.dup.each do |laser2|
      if laser2.x < 0 - 50 then 
        @laser2.delete laser2
      end 
    end
    when :winner
      @win_song.play
      @game_song.stop
      @batalha_song.stop
      @over_song.stop
      @menu_song.stop
    when :tutorial
		  @game_song.stop
      @batalha_song.stop
      @over_song.stop
		when :credits
      @over_song.stop
      @batalha_song.stop
		 	@game_song.stop
    when :over
       @over_song.play(true)
       @batalha_song.stop
       @game_song.stop
       @menu_song.stop
     end
	end

	#MENU DO JOGO E AÇÕES
	def button_down(id)
    case @estado
    when :title
      case id
      when Gosu::KbUp
        @opc_song.play
        if @option > 1 then @option -= 1 elsif @option == 1 then @option = 4 end
      when Gosu::KbDown
        @opc_song.play
        if @option < 4 then @option += 1 elsif @option == 4 then @option = 1 end
      when Gosu::KbReturn
        if @option == 1 then
          @estado = :game
          @jogador = Jogador.new(self)
          @pontuacao = 0
          @asteroide = []
          @satelite = []
          @cometa = []
          @explosao = []
          @laser = []
          @seg = 0
          @min = 0
          @scroll_x = 0
          @scroll_x_lua = 0
        end
        if @option == 2 then
          @estado = :game_batalha
          @jogador = Jogador.new(self)
          @jogador2 = Jogador2.new(self)
          @laser = []
          @laser2 = []
          @estrela = []
	        @vida_nave1 = 100
          @vida_nave2 = 100    
        end
        if @option == 3 then
          @estado = :tutorial
        end
        if @option == 4 then
          @estado = :credits
        end
      when Gosu::KbEscape
        exit
      end
    when :game
      case id
      when Gosu::KbSpace
        @laser.push Laser.new(self, @jogador.pos_x, @jogador.pos_y) if @laser.size < 2
        @laser_song.play
        @menu_song.stop
        @over_song.stop
      when Gosu::KbEscape
        @opc_song.play
        @estado = :title
      end
    when :game_batalha
      case id
      when Gosu::KB_NUMPAD_0
        @laser2.push Laser2.new(self, @jogador2.pos_x, @jogador2.pos_y) if @laser2.size < 1
        @laser_song.play
      when Gosu::KbSpace
        @laser.push Laser.new(self, @jogador.pos_x, @jogador.pos_y) if @laser.size < 1
        @laser_song.play
      when Gosu::KbEscape
          @estado = :title
      end
    when :over
      case id
      when Gosu::KbEscape
        @opc_song.play
        @estado = :title
      end
    when :winner
      case id
      when Gosu::KbEscape
        @opc_song.play
        @estado = :title
      end
    when :tutorial
      case id
      when Gosu::KbEscape
        @opc_song.play
        @estado = :title
      when Gosu::KbRight
        @opc_song.play
        @estado = :tutorial_batalha
      end
    when :tutorial_batalha
      case id
      when Gosu::KbEscape
        @opc_song.play
        @estado = :title
      when Gosu::KbLeft
        @opc_song.play
        @estado = :tutorial
      end
    when :credits
      case id
      when Gosu::KbEscape
        @opc_song.play
        @estado = :title
      end
    end
  end
end 

window = AlienGame.new
window.show
