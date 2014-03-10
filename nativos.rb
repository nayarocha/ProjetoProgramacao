require 'gosu'
class Nativo
	attr_reader :x_nativo, :y_nativo
	def initialize(janela)
		@janela = janela 
		@nativo = Gosu::Image.new(@janela,"imagens/nativo.png",true)
		@x_nativo = rand(@janela.width)
		@y_nativo = 0

	end 

	def draw 
		@nativo.draw(x_nativo,@y_nativo,2)
	end 

	def update 
		@y_nativo = @y_nativo + 2
	end 

#mesma posição do nativo e do inimigo
	def coinc(inimigo)
		inimigo.reject! do |inimigo|
			Gosu::distance(@x_nativo,@y_nativo, inimigo.x, inimigo.y) < 40
		end 
	end	
end 
