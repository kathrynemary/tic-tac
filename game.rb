class Game

  def initialize
    puts "Welcome to my Tic Tac Toe game"
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @computer = get_symbols(@computer, "the computer")
    @human = get_symbols(@human, "yourself")
    compare_players
    determine_order
  end

  def get_symbols(player, title)
    puts "What kind of symbol would you like to use for #{title}? Please use only one character."
    answer = gets.chomp
    if answer.length == 1
      player = answer
    else puts "Nice try, buddy. Only one character here:"
      get_symbols(player, title)
    end
  end

  def compare_players
    if @human == @computer
      puts "You can't do that! Pick a different symbol for yourself."
      @human = get_symbols(@human, "yourself")
      compare_players
    else
      puts "As you wish!"
    end
  end
  
  def determine_order
    puts "Would you like to go first? Please enter Y or N \n"
    answer = gets.upcase.chomp
    if answer == "Y"
      get_human_spot
      play_loop
    elsif answer == "N"
      puts "A foolish choice - Muahaha! \n"
      play_loop
    else
      puts "I don't understand that. \n"
      determine_order
    end
  end

  def default_board
    (0..8).each_with_index do |space, index|
      print "|_#{@board[space]}_|"
        if index % 3 == 2
          puts "\n"
        end
    end
  end

  def play_loop
    until game_is_over
      eval_board
      if !game_is_over
        get_human_spot
      end
    end
    who_won
  end

  def eval_board
    if @board[4] == "4"
      spot = 4
      @board[spot] = @computer
    else
      spot = get_best_move.to_i
      if @board[spot] != @computer && @board[spot] != @human
        @board[spot] = @computer
      end
    end
    puts "I have chosen spot #{spot}!"
  end

  def get_human_spot
    default_board
    puts "Please select your spot."
    spot = gets.chomp.to_i
    if @board[spot] != @human && @board[spot] != @computer
      @board[spot] = @human
    else
      puts "That's not a valid answer. I'll give you one more chance."
      get_human_spot
    end
  end

  def get_best_move
    almost_winning (@computer)
    if @best_move != nil
      return @best_move
    else
      almost_winning (@human)
      if @best_move != nil
        return @best_move
      else
        random_space
        return @best_move
      end
    end
    @best_move = @best_move.to_i
  end

  def almost_winning (player)
    find_available_spaces
    @available_spaces.each do |as|
      @board[as.to_i] = player
      if we_have_a_winner(@board)
        @best_move = as.to_i
        @board[as.to_i] = as
        return @best_move
      else
        @board[as.to_i] = as
        @best_move = nil
      end
    end
  end
  
  def find_available_spaces
    @available_spaces = []
    @board.each do |x|
      if x != @human && x != @computer
        @available_spaces << x
        return @available_spaces
      end
    end
  end

  def random_space
    @best_move = @available_spaces.sample
  end

  def game_is_over
    if we_have_a_winner(@board) || tie(@board)
      return true
    end
  end

  def we_have_a_winner(b)
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

  def who_won
    default_board
    puts "Game Over!"
    if tie(@board)
      puts "We have tied! I'll get you next time." 
    end
  end

end