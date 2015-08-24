=begin
get_best_move is huge
say who won
offer to play again?
wont work if tie/computer wins???????******************8
=end

class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @computer = get_symbols(@computer, "the computer")
    @human = get_symbols(@human, "yourself")
    if @human == @computer
      puts "You can't do that! Pick a different symbol for yourself."
      @human = get_symbols(@human, "yourself")
    end
  end

  def default_board
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end

  def get_symbols(player, title)
    puts "What kind of symbol would you like to use for #{title}?"
    player = gets.chomp
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    determine_order
  end
  
  def determine_order
    puts "Would you like to go first? Please enter Y or N \n"
    answer = gets.upcase.chomp
      if answer == "Y"
        human_turn
      elsif answer == "N"
        puts "A foolish choice - Muahaha! \n"
        eval_board
        human_turn
      else
        puts "I don't understand that. \n"
        determine_order
      end
  end

  def human_turn
    default_board
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      get_human_spot
      if !game_is_over(@board) && !tie(@board)
        eval_board
      end
      default_board
    end
    who_won
  end

  def who_won
    puts "Game Over!"
    if tie(@board)
      puts "We have tied! I'll get you next time." 
    end
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if @board[spot] != @human && @board[spot] != @computer
        @board[spot] = @human
      else
        puts "That's not a valid answer. I'll give you one more chance."
        default_board
        get_human_spot
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @computer
      else
        spot = get_best_move(@board, @computer)
        if @board[spot] != @human && @board[spot] != @computer
          @board[spot] = @computer
        else
          spot = nil
        end
      end
      puts "I have chosen spot #{spot}! \n"
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {}) #best_score, depth, next_player no other matches
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != @human && s != @computer
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

  def game_is_over(b)
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
    b.all? { |s| s == @human || s == @computer }
  end
end

game = Game.new
game.start_game
