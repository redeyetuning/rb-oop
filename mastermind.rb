# Build the game assuming the computer randomly selects the secret colors and the human player must guess them. 
#Remember that you need to give the proper feedback on how good the guess was each turn!
#Now refactor your code to allow the human player to choose whether she wants to be the creator of the secret code or the guesser.
#Build it out so that the computer will guess if you decide to choose your own secret colors. Start by having the computer guess randomly 
#(but keeping the ones that match exactly).
#Next, add a little bit more intelligence to the computer player so that, if the computer has guessed the right color but the wrong position, 
#its next guess will need to include that color somewhere. Feel free to make the AI even smarter.

#The codebreaker tries to guess the pattern, in both order and color, within twelve (or ten, or eight) turns. 
#Each guess is made by placing a row of code pegs on the decoding board. Once placed, the codemaker provides feedback by placing from zero to 
#four key pegs in the small holes of the row with the guess. A colored or black key peg is placed for each code peg from the guess which is 
#correct in both color and position. 
#A white key peg indicates the existence of a correct color code peg placed in the wrong position.[


# 6 colours = "[:blue, :green, :orange, :purple, :red, :yellow]"
# @turn = 12 turn +-= 1
# @board = 4 x 12
# 

class Mastermind
	attr_accessor :code, :guess 


	def initialize
		
	end
	
	def self.play
			puts "Do you want to (G)uess or(C)hoose the secret code?"
			choice = gets.chomp.upcase until choice == "G" || choice == "C"
			if choice == "G" then player_plays else ai_plays end 
	end

	class << self


		#private
		
		
		def player_plays
			i = 1
			won = false 
			puts "\nYou have 12 guesses to identify the A.I's code. A.I. is generating a code.... \n\n"
			code = generate_code
			#print "@code=#{@code}\n"
			while i<13 && !won
				guess = get_code("Your Guess", i)
				won = true if match?(code, guess, true)
				i += 1
			end
			puts "You ran out of guesses!" if i ==13 
		end

		def ai_plays
			puts "AI plays"
			code = get_code("Choose your code!")
			answers = [*1..6].repeated_permutation(4).to_a.collect{|x| x = num_to_letter(x)}
			print answers.length
			print code
			guess = ["B","G","O","P"]
			puts "A.I.'s' first guess is #{guess}"
			

			match?(code,guess) # first guess
			match_result = @output.dup
			puts match_result

			answers.select! do |x| 
				match?(x,guess)
				guess = answers.sample
				match_result == @output
			end
			#puts answers.length
			
			#match?(code,guess,true) # first guess
			#	match_result = @output.dup
			#	puts match_result

			#	answers.select! do |x| 
			#		match?(x,guess)
			#		match_result == @output
			#		guess = answers.sample
					
			#	end
			
			puts answers.length
			
			#print answers
		
			print @output
		end


		def get_code(reason, *round)	
			puts "#{reason} #{round[0]}\nInsert code as 4 comma separated values from: (B)lue, (G)reen, (O)range, (P)urple, (R)ed, or (Y)ellow."
			code = gets.chomp.upcase.split(",")
			until code.length ==4 && code.all?{|x| x.match(/[BGOPRY]/)} do
				puts "That code is not valid. Please try again!"
				code = gets.chomp.upcase.split(",")
			end
			return code
		end

		def generate_code
			code =[]
			4.times {code.push(["B","G","O","P","R","Y"].sample)}
			puts "A.I. has generated a 4-character code from the colours (B)lue, (G)reen, (O)range, (P)urple, (R)ed, and (Y)ellow!"
			puts
			return code
		end

		def num_to_letter(code)
			output = []
			code.each do |x|
				output.push case x
					when 1 then ("B") 
					when 2 then ("G")
					when 3 then ("O")
					when 4 then ("P") 
					when 5 then ("R") 
					when 6 then ("Y")
				end
			end
			
			return output
		end

		def match?(code, guess, *print)
			test_code = code.dup
			test_guess = guess.dup
			@output = {:TM=>0,:CM=>0,:X=>0}
			
			test_guess.each_with_index do |x,i|
				test_code[i] = "-" and test_guess[i] = "+" and	@output[:TM] +=1 if x == test_code[i]
			end
			
			test_guess.each_with_index do |x,i|
				if test_code.index(x)
					test_code[test_code.index(x)] = "-"
					test_guess[i] = "+" 
					@output[:CM] +=1
				elsif x.to_s.match(/[BGOPRY123456789]/)
					@output[:X] += 1
				end  
			end
			
			if @output[:TM] == 4
				puts "You cracked the code!" if print[0]
				return true
			else 
				print "You had #{@output[:TM]} EXACT MATCHES and #{@output[:CM]} COLOUR ONLY MATCHES \n\n" if print[0]
			end
		end



	end
end