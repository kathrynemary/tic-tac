#tests and shit!

class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @computer = ""
    @human = ""
  end

#move me!
  def get_symbols(player)
    puts "What kind of symbol would you like to use for #{player}?"#well this isn't displaying
    player = gets.chomp
    puts "'#{player}' you say?"
    return player
  end

  def start_game #yeesh this is a lot in one method
    puts "Welcome to my Tic Tac Toe game"
    computer = get_symbols(computer)
    human = get_symbols(human)
    determine_order
    
  end

  def human_first  #well this is not working.
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please select your spot." 
    play_game
  end
    
  def play_game
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    end
    puts "Game over"
  end

  def determine_order
    puts "Would you like to go first? Please enter Y or N \n"
    answer = gets.upcase.chomp
      if answer == "Y"
        human_first
      elsif answer == "N"
        puts "Your loss! Muahaha! \n"
        play_game
      else
        puts "I don't understand that. \n"
        determine_order #make so it breaks eventually?
      end
  end

  def get_human_spot #why are you not displayingggggg
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != "#{@human}" && @board[spot] != "O"
        @board[spot] = "#{@human}"
      else
        spot = nil
      end
    end
  end

  def eval_board #announce if is a tie or not
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @computer
      else
        spot = get_best_move(@board, @computer)
        if @board[spot] != "#{@human}" && @board[spot] != "O"
          @board[spot] = @computer
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "#{@human}" && s != "O"
        available_spaces << s
      end
    end
    available_spaces.each do |as|
      board[as.to_i] = @computer
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @human
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = as
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(b) #i don't think it even displays a message? should offer to play again.

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "#{@human}" || s == "O" }
  end
end

game = Game.new
game.start_game
