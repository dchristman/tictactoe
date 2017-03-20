class Player
  attr_reader :name
  @@players = {}
  @@board_state = {:A => 'A', :B => 'B', :C => 'C',
                   :D => 'D', :E => 'E', :F => 'F',
                   :G => 'G', :H => 'H', :I => 'I'}
  @@winning_positions = [[:A, :B, :C],
                         [:D, :E, :F],
                         [:G, :H, :I],
                         [:A, :D, :G],
                         [:B, :E, :H],
                         [:C, :F, :I],
                         [:A, :E, :I],
                         [:C, :E, :G]]

  def initialize (name, symbol)
    @name = name
    @squares = []
    @@players[symbol] = self
    @symbol = symbol.to_s.upcase
  end

  #Lets the player take their turn.
  def take_turn
    valid_move = false
    while valid_move == false
      puts "#{@name}, where would you like to play?"
      current_move = gets.chomp.to_sym
      if @@board_state.keys.include?(current_move) && Player.is_valid?(current_move)
        @squares.push(current_move)
        @@board_state[current_move] = @symbol
        valid_move = true
      else
        puts "Please enter a valid move"
      end
    end
  end

  #Check to see if the player has won
  def check_for_win
    @@winning_positions.each do |winning_position|
      if winning_position.all?{ |square| @squares.include?(square) }
        return true
      end
    end
    return false
  end

  #Displays the current board state
  def Player.show_board
    puts @@board_state[:A] + '|' + @@board_state[:B]  + '|' + @@board_state[:C]
    puts '_____'
    puts @@board_state[:D] + '|' + @@board_state[:E]  + '|' + @@board_state[:F]
    puts '_____'
    puts @@board_state[:G] + '|' + @@board_state[:H]  + '|' + @@board_state[:I]
  end

  #Check to see if the move is valid
  def Player.is_valid?(move)
    if @@board_state[move] == 'X' || @@board_state[move] == 'O'
      return false
    else
      return true
    end
  end

  #Check to see if there are no more valid moves
  def Player.check_for_draw
    @@board_state.values.all? {|value| value == 'X' || value == 'O'}
  end
end

puts "Who will be playing X's?"
x_player = Player.new(gets.chomp, :x)

puts "Who will be playing O's?"
o_player = Player.new(gets.chomp, :o)



current_player = x_player

game_over = false
while !game_over
  Player.show_board
  current_player.take_turn
  if current_player.check_for_win
    puts "Congratulations #{current_player.name}, you have won!"
    game_over = true
  end
  if Player.check_for_draw
    puts "Sorry, no winner this time"
    game_over = true
  end
  current_player = current_player == x_player ? o_player : x_player
  puts ""
end
