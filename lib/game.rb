class Game
  
  attr_accessor :board, :player_1, :player_2, :input, :computer_1, :computer_2

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), 
    computer_1 = Players::Computer.new("X"), computer_2 = Players::Computer.new("O"), board = Board.new) 
    @player_1 = player_1
    @player_2 = player_2 
    @computer_1 = computer_1
    @computer_2 = computer_2
    @board = board
    
  end 


 WIN_COMBINATIONS = [ #Array with all possible combinations
    [0,1,2], #Top Row 
    [3,4,5], #Middle Row 
    [6,7,8], #Bottom Row 
    [0,3,6], #Left Column
    [1,4,7], #Middle Column
    [2,5,8], #Right Column
    [0,4,8], #Diagonal Left-to-right
    [2,4,6]  #Diagonal Right-to-left
  ]
 
  def turn
    puts "Please enter a number 1-9:"
    input = current_player.move(@board)
    if @board.valid_move?(input.to_s)
      @board.update(input, current_player)
    elsif @board.full?
      draw?
    else
    puts "Invalid Move"
      #@board.display
      turn
    end
    @board.display
  end 
  
   def current_player
       board.turn_count.odd? ? player_2 : player_1
   end
  
   def won? #Double checks if the combo inputted has won
    WIN_COMBINATIONS.each |combo|
      @board.cells[combo[0]] && @board.cells[combo[1]] && @board.cells[combo[2]] == " "
    }
    b = WIN_COMBINATIONS.find{
      |combo|
      @board.cells[combo[0]] == "O" && @board.cells[combo[1]] == "O" && @board.cells[combo[2]] == "O"
    }
    return a || b
  end
  
   def draw? #Checks methods won for false & full for true, then game is a draw
    !won? && @board.full?
  end
  
  def over? #If the game is won or a draw, game is now over
    won? || draw?
  end
  
  def winner 
    if won?
      @board.cells[won?[0]] == "X" ? "X" : "O"
    else
      nil
    end
  end
  
    def play #Checks if game is over, if false, next turn; if won, congrats;
      while over? == false
        turn
       end
      if won?
       puts "Congratulations #{winner}!"
      elsif draw?
       puts "Cat's Game!"
      end
    end
    
  def start 
    puts "Who is playing?"
    puts "0 - Computer VS Computer"
    puts "1 - You VS Computer"
    puts "2 - You VS Friend"

    input = gets.strip

  case input
    when "0"
      Game.new(computer_1, computer_2).play
      puts "Incredible! Would you like to play again?"
      try_again
    when "1"
      Game.new(player_1, computer_2).play
      puts "Would you like to play again?"
      try_again
    when "2"
      Game.new(player_1, player_2).play
      puts "Would you like to play again?"
      try_again
    else
      puts "That is an invalid entry"
      start
  end
  end
  
  def try_again
  puts "Please input y or n"
  input = gets.strip
  case input
    when "y"
      start
    when "n"
      puts "Thanks For Playing!"
    else
      try_again
  end
end 
end 