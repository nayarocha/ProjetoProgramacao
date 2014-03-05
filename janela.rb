$LOAD_PATH << '.'
require 'gosu'
require 'player'
require 'inimigo'
require 'nativos'

class GuerraEntreMares < Gosu::Window 
	def initialize
		super(1024,389,false)
		self.caption = "Guerra entre mares"
		@bg_tela = Gosu::Image.new(self, "imagens/bg2.png",true)
		@player = Player.new(self)
		@inimigos = []	
		#Bg em movimento
		@bg_x = 1
		@nativos = 5.times.map {Nativo.new(self)}
		
		@font = Gosu::Font.new(self, Gosu::default_font_name,20)

		@time = 0.0
		@estado = "INICIO"
		@bg_inicio = Gosu::Image.new(self, "imagens/bg_final.png",true)
	end 

	#desenha a janela
	def draw
		@bg_inicio.draw(0,0,0)
		if(@estado == "INICIO")then 
			#@font.draw("Pressione I para começar", 10, 10, 3,1.0,1.0, 0xffffff00)
		elsif (@estado == "JOGANDO")then 
			@bg_tela.draw(@bg_x,0,0)
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
			#fim 
		end	 
	end 

	#logica do jogo
	def update
		if (@estado == "INICIO")then 
			if (button_down?(Gosu::Button::KbI)) then 
				@estado = "JOGANDO"
			end 
		elsif (@estado == "JOGANDO")then 	
			if rand(1000) < 15 then  
				@nativos.push(Nativo.new(self))
			end 

			for nativo in @nativos do 
				nativo.update
			end 
		
			#Queda dos inimigos - homens bombas
      		if rand(2000) < 15  then
      			@inimigos.push(Inimigo.new(self))
			end
      
    		for inimigo in @inimigos do 
				inimigo.update
			end
			#capturando nativos
			@player.captura_nativo(@nativos)
			@player.captura_inimigo(@inimigos)
			#Movimentando o player 
			if (button_down? Gosu::Button::KbRight) then 
				@player.mov_direita	
				#movimento do background
				@bg_x = @bg_x - 5
				if(@bg_x < -841 )then @bg_x = 0 end 
			end 
			
			if(button_down? Gosu::Button::KbLeft) then
				@player.mov_esquerda
				#movimento do background
				@bg_x = @bg_x + 5
				if(@bg_x > 0)then @bg_x = 0 end 
			end 

			@time += 1.0/60.0
			if (@time.to_i == 60)then
				@estado = "FIM"
			end 			
		elsif (@estado == "FIM")then 
			#fim
		end 		
	end 
end