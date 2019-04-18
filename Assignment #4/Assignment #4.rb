# Problem 1

class Player
  attr_reader :name
  attr_accessor :marker

  def initialize(name)
    @name = name
  end

  def to_s
    name.capitalize
  end


  def inspect
    to_s
  end

  def ask(question)
    print question
    gets.chomp
  end

  def ==(subject)
    to_s.downcase.eql?(subject.to_s.downcase)
  end
end

class Board
  attr_reader :status

  def initialize()
    @squares = Array.new(9)
  end
  

  def move(args)
    self.position = args[:position]
    self.player = args[:player]

    return false unless approved?

    mark_square
    redraw

    return true
  end


  def inspect
    
  end


  def game_over?
    if winner?
      self.status = :win
      true
    elsif tie?
      self.status = :tie
      true
    else
      false
    end
  end


  def display
    @grid.each do | row |
      row.each do | val |
        if val.nil?
          print "- "
        else
          print "#{val} "
        end
      end
      puts " "
    end
  end


  private

  def winner?
    possible_combinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
    ]

    possible_combinations.any? { |line| line.all? { |pos| squares[pos] == player.marker  }  }
  end


  def tie?
    not winner? and full?
  end


  def approved?
    if not valid_move?
      self.status = :invalid
      false
    elsif not legal_move?
      self.status = :illegal
      false
    else
      self.status = nil
      true  
    end
  end


  def valid_move?
    position.between?(0,8)
  end


  def legal_move?
    squares[position].nil?
  end


  def full?
    squares.all?{ |square| not square.nil? }
  end


  def position=(position)
    @position = to_zero_based(position.to_i)
  end


  def mark_square
    squares[position] = player.marker
  end


  def redraw
    @grid = [squares[0..2], squares[3..5], squares[6..8]]
  end


  def to_zero_based(position)
    position - 1
  end


  def squares
    @squares
  end


  def position
    @position
  end

  def player
    @player
  end


  def player=(player)
    @player = player
  end


  def status=(msg)
    @status = msg
  end
end



require_relative "board"
require_relative "player"

class Game
  def initialize(player1_name, player2_name)
    @players = Array.new
    @players << Player.new(player1_name)
    @players << Player.new(player2_name)
  end


  def play_game(name)
    player = get_player(name)

    if player.nil?
      puts "I don't know that player. Please try again."
    else
      self.current_player = player
      setup_players

      @board = Board.new

      while true
        play

        if board.game_over?
          puts status_message
          return
        else
          swap_players
        end
      end
    end
  end


  private


  def next_move
    "#{current_player}, enter your next #{current_player.marker} move (1-9): "
  end


  def play
    while true
      position = current_player.ask "#{current_player}, enter your next #{current_player.marker} move (1-9): "
      moved = board.move(:position => position, :player => current_player)

      puts status_message if status_message

      board.display

      return if moved
    end
  end


  def status_message
    case board.status
    when :win
      "#{current_player}, you won!"
    when :tie
      "The game has been ended in a tie!"
    when :illegal
      "Bad move dude! you go again."
    when :invalid
      "Dude! your move should be 1-9, you go again."
    else
      false
    end
  end


  def get_player(name)
    players.detect { |player| player == name }
  end


  def setup_players
    players.each do |player|
      if player == current_player
        player.marker = 'O'
      else 
        player.marker = 'X'
      end
    end
  end


  def current_player=(player)
    @current_player = player
  end


  def current_player
    @current_player
  end


  def board
    @board
  end


  def players 
    @players
  end


  def swap_players
    self.current_player = players.detect { |player| not(player == current_player) }
  end
end

