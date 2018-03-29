module TicTacToe
	extend self
	
	def initialize
		clear_board
	end 
	
	def play
		initialize
		move(@player) until  @won || grid_full?
	end

	private


		def clear_board
			@grid = *(1..9)
			@player = "X"
			@won = false
		end

		def move(player)
			puts "Which grid square do you choose Player #{player}?"
			display
			grid_square = gets.chomp 
			grid_square = gets.chomp until input_valid?(grid_square) && grid_square_empty?(grid_square)
			add_to_grid(player, grid_square)    
			won?(player)
			@player == "X" ? @player = "O" : @player = "X" 
		end

		def add_to_grid(player, grid_square)
			@grid[grid_square.to_i-1] = player
		end

		def input_valid?(choice)
			if choice.to_s.match(/[^1-9]/) then puts "That is not a valid choice. Please choose a number 1-9." else true end
		end

		def grid_square_empty?(grid_square)
			if @grid[grid_square.to_i-1].to_s.match(/[^1-9]/) then puts "That square is taken. Please choose again." else true end
		end

		def display 
			puts "| #{@grid[0]} #{@grid[1]} #{@grid[2]} | \n| #{@grid[3]} #{@grid[4]} #{@grid[5]} | \n| #{@grid[6]} #{@grid[7]} #{@grid[8]} |" 
		end

		def won?(player)
			test_string = "#{@grid[0]}#{@grid[1]}#{@grid[2]}|#{@grid[3]}#{@grid[4]}#{@grid[5]}|#{@grid[6]}#{@grid[7]}#{@grid[8]}|#{@grid[0]}#{@grid[3]}#{@grid[6]}|#{@grid[1]}#{@grid[4]}#{@grid[7]}|#{@grid[2]}#{@grid[5]}#{@grid[8]}|#{@grid[0]}#{@grid[4]}#{@grid[8]}|#{@grid[2]}#{@grid[4]}#{@grid[6]}"
			if test_string.match(/(X{3}|O{3})/)
				puts "Player #{player} won!"
				@grid.collect!{|x| x == player ? x : x = " "} 
				display
				@won = true
			end

		end

		def grid_full?
			if @grid.none?{|x| x.to_s.match(/[0-9]/)}
				puts "All squares are full! It's a draw"
				display
				return true
			end
		end
	
end