$LOAD_PATH << '.'
require 'gosu'
require 'player'
require 'inimigo'
require 'nativos'
require 'bg_game'

class GuerraEntreMares < Gosu::Window 
	def initialize
		super(1024,389,false)
		self.caption = "Guerra entre mares"
		@player = Player.new(self)
		@bggame = BgGame.new(self)
		@inimigos = []	
		@bombas = []
		@nativos = 5.times.map {Nativo.new(self)}
	
		@font = Gosu::Font.new(self, Gosu::default_font_name,20)
		@font_inicio = Gosu::Font.new(self, Gosu::default_font_name, 50)

		@time = 0.0
		@estado = "INICIO"
		@bg_inicio = Gosu::Image.new(self, "imagens/bg_final.png",true)
		@numero_de_ini= 4000
		@numero_de_nat= 100
		
		@fim=30
		@delta=0

		@explodir = false
	end 
	
	#desenha a janela
	def draw
		@bg_inicio.draw(0,0,0)
		if(@estado == "INICIO")then 
			@font_inicio.draw("Pressione [I] para iniciar o jogo", 190, 100, 3,1.0,1.0, 0xff0000ff)
		elsif (@estado == "JOGANDO")then 
			@bggame.draw()
			@player.draw()
			@font.draw("Soldados capturados: #{@player.score}" , 10, 10, 3,1.0,1.0, 0xffffff00)
			@font.draw("Tempo: #{@time.to_i} S" , 10, 40, 3,1.0,1.0, 0xffffff00)
			

			for inimigo in @inimigos do 
				inimigo.draw
			end

			for nativo in @nativos do 
				nativo.draw
			end 	

		elsif (@estado == "FIM")then
			@bg_inicio.draw(0,0,0)
			@font_inicio.draw("IHUUUUUUUUUUUU", 190, 100, 3,1.0,1.0, 0xff0000ff)
		end	 
	end 

	#logica do jogo
	def update
		if (@estado == "INICIO")then 
			if (button_down?(Gosu::Button::KbI)) then 
				@estado = "JOGANDO"
			end 
		elsif (@estado == "JOGANDO")then 	

			if rand(@numero_de_nat) < 15 then  
				@nativos.push(Nativo.new(self))
			end 

			for nativo in @nativos do 
				nativo.update
			end 
				
			#Queda dos inimigos - homens bombas
      		if rand(@numero_de_ini) < 15  then
      			@inimigos.push(Inimigo.new(self))
			end
      
    		for inimigo in @inimigos do 
				inimigo.update
			end
			#capturando nativos
			@player.captura_nativo(@nativos)
			@player.captura_inimigo(@inimigos)
			
			#eliminando inimigos muito proximos dos natvos
			nativo.coinc(@inimigos)	

			#Movimentando o player 
			if (button_down? Gosu::Button::KbRight) then 
				@player.mov_direita	
				@bggame.bg_esquerda
			end 
			
			if(button_down? Gosu::Button::KbLeft) then
				@player.mov_esquerda
				@bggame.bg_direita 
			end 
			
			#numero de inimigos aumetando e de nativos diminuindo
			if(@numero_de_ini.to_i > 900)then
				@numero_de_ini= @numero_de_ini / (@time + 8).to_i
			else
				@numero_de_ini= 900
			end
			if(@numero_de_nat.to_i < 1000)then
				@numero_de_nat= @numero_de_nat * (@time + 1).to_i 
			else
				@numero_de_nat= 1000
			end

			@time += 1.0/50.0			
			
			if @player.captura_inimigo @inimigos then 
				for bomba in @bombas do 
					bomba.update
					@captura_inimigo.update 
				end
				@delta = 1
			end
			@fim = @fim-@delta
			if (@fim==0) then
				@estado="FIM"
			end
		elsif (@estado == "FIM")then 
			
		end 		
	end 
end
