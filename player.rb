require 'gosu'
class Player
	attr_reader :position_x , :position_y 
	
	def initialize(janela)
		@janela = janela
		@player = Gosu::Image.new(@janela,"imagens/barco.png",true)
		@position_x = 20
		@position_y = 320

	end 	

	def draw 
		@player.draw(@position_x,@position_y,1)
	end

	def mov_direita 
		@position_x = @position_x + 5
		if(@position_x >500)then @position_x = 500 end  
	end

	def mov_esquerda
		@position_x = @position_x - 5 
		if(@position_x < 5)then @position_x = 5 end 
	end 

end 