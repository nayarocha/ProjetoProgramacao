$LOAD_PATH << '.'

require 'gosu'
require 'player'
require 'inimigo'

class GuerraEntreMares < Gosu::Window 
	def initialize
		super(1024,389,false)
		self.caption = "Guerra entre mares"
		@bg_tela = Gosu::Image.new(self, "imagens/bg2.png",true)
		@player = Player.new(self)
		@inimigos = []
		#Bg em movimento
		@bg_x = 1
		@y=0
	end 

	#desenha a janela
	def draw
		@bg_tela.draw(@bg_x,0,0)
		@player.draw()
		
		for inimigo in @inimigos do 
			inimigo.draw
		end

	end 

	#logica do jogo
	def update

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
			@y = @y + 5
			if(@bg_x > 0)then @bg_x = 0 end 
		end 

		#if rand(30) < 500 and @inimigos.size < 400 then
      	if rand(2000) < 15  then
      		@inimigos.push(Inimigo.new(self))
		end
      
    	for inimigo in @inimigos do 
			inimigo.update
		end
	end 
end