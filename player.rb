require 'gosu'
class Player
	attr_reader :position_x , :position_y , :score , :acertado , :bomba
	def initialize(janela)
		@janela = janela
		@player = Gosu::Image.new(@janela,"imagens/barco.png",true)
		@position_x = 50
		@position_y = 320
		@score = 0

		@bomba = Gosu::Image::load_tiles(@janela, "imagens/explosao.png",192,195,true)
		@bombas = []
		@acertado = false

		@x_bomba = 0
		@y_bomba = 0
	end 	

	def mov_direita 
		@position_x = @position_x + 5
		if(@position_x >1024)then @position_x = 0 end  
	end

	def mov_esquerda
		@position_x = @position_x - 5 
		if(@position_x < 0)then @position_x = 1024 end 
	end 

	def captura_nativo(nativos)
		n_nativos = nativos.size
		nativos.reject! do |nativo|
			Gosu::distance(@position_x,@position_y, nativo.x_nativo, nativo.y_nativo) < 40
		end 
		n = n_nativos - nativos.size 
		@score += n*1
	end 

	def captura_inimigo(inimigos)
		#n_inimigos = inimigos.size
		inimigos.reject! do |inimigo|
			@acertado = Gosu::distance(@position_x,@position_y, inimigo.x, inimigo.y) < 40
		end 
	end 


	def draw 
		img_bomba = @bomba[Gosu::milliseconds / 100 % @bomba.size]

		if @acertado 
			for bomba in @bombas do 
				@bomba.draw(@x_bomba,@y_bomba,3)
			end 
		else
			@player.draw(@position_x-50,@position_y,1)
		end 
	end
end 


