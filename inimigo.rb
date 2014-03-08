require 'gosu'
class Inimigo 
	attr_reader :y , :x

    def initialize(janela)
		  @janela = janela 
		  @img_inimigo = Gosu::Image::load_tiles(@janela,"imagens/inimigo.png",65,80,false)
		  @x = rand(@janela.width / 2 + 100)
      @y = 0
    end

    
    def draw 
        img = @img_inimigo[Gosu::milliseconds / 800 % @img_inimigo.size]
        img.draw(@x,@y,2)
    end

    def update 
        @y = @y + 2
    end

    #def x 
       # @x 
    #end 

   # def y
       # @y
   # end 
end