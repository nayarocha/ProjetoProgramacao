require 'gosu'
class BgGame 
	attr_reader  :bg_x , :bg_y 
	def initialize(janela)
		@janela = janela 
		@bg_tela = Gosu::Image.new(@janela, "imagens/bg2.png",true)
		@bg_x = 0
		@bg_y = 0
	end 

	def draw 
		@bg_tela.draw(@bg_x,0,0)
	end

	def bg_direita 
		@bg_x +=  5
		if (bg_x > 0) then @bg_x = -1024 end 
	end

	def bg_esquerda 
		@bg_x -= 5  
		if (@bg_x < -1024) then @bg_x = -1 end 
	end
end 

