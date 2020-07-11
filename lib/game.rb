class Game
  
  attr_accessor :board, :player_1, :player_2, :input, :computer_1, :computer_2

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new) 
    @player_1 = player_1
    @player_2 = player_2 
    @board = board
    
  end 
  
  def computer_1(computer_1 = Players::Computer.new("X"))
    @computer_1 = computer_1
  end 
  
  def computer_2(computer_2 = Players::Computer.new("O"))
    @computer_2 = computer_2
  end 


 WIN_COMBINATIONS = [ #Array with all possible combinations
    [0,1,2],
    [3,4,5], 
    [6,7,8],  
    [0,3,6], 
    [1,4,7], 
    [2,5,8], 
    [0,4,8], 
    [2,4,6]  
  ]
 
  def turn
    puts "Enter a number 1-9:"
    input = current_player.move(@board)
    if @board.valid_move?(input.to_s)
      @board.update(input, current_player)
    elsif @board.full?
      draw?
    else
    puts "Invalid Move"
      turn
    end
    @board.display
  end 
  
   def current_player
       board.turn_count.odd? ? player_2 : player_1
   end
  
   def won? #Double checks if the combo inputted has won
     WIN_COMBINATIONS.each do |combo|
        if @board.cells[combo[0]] == @board.cells[combo[1]] &&
          @board.cells[combo[1]] == @board.cells[combo[2]] &&
          @board.taken?(combo[0]+1)
          return combo
        end
      end
    return false
  end
  
   def draw? 
    @board.full? && !won?
  end
  
  def over? 
    won? || draw?
  end
  
  def winner 
    if won?
      @board.cells[won?[0]] if won?
    end
  end
  
    def play 
      turn until over?
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