module Players
  class Human < Player

    def move(board)
      input = gets.strip
      index = input.to_i - 1
    end
  end
end