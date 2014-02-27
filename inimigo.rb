require 'gosu'
require 'player'
require 'janela'


class Inimigo 
	attr_reader :x, :y, :inimigo, :width 

    def initialize(janela)
		@janela = janela 
		@inimigos = Gosu::Image::load_tiles(@janela,"imagens/inimigo.png",65,80,false)
		@x = rand(@janela.width)
        @y = 0

       
	end 

    def draw 
    	inimigo = @inimigos[Gosu::milliseconds / 100 % @inimigos.size]
    	inimigo.draw = (@x, @y, 3)
    end

    def update 
        @y = @y + 5
        
    end 

end