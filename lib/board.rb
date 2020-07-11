class Board
  
  attr_accessor :cells
  
  @cells = []

def initialize
    self.cells = Array.new(9, " ") #new board setup 
  end 
  
  def display   #Displays the TicTacToe game board 
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def reset!
      @cells.clear
     @cells = Array.new(9," ")
  end 
  
  def position(input)
    input = input.to_i
    @cells[input - 1]
  end 
  
  def full? 
    !@cells.any?{|x| x == "" || x == " "}
  end
  
  def turn_count 
    @cells.count{|cell| cell == "X" || cell == "O"}
  end
  
  def taken?(input)
    position(input) == "X" || position(input) == "O"
  end 

  def valid_move?(index) 
    index.between?("1","9") && !taken?(index)
  end

   def update(position, player)
      self.cells[position.to_i-1] = player.token
  end


end