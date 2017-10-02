# define array & players
board = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
player1 = 'X'
player2 = 'O'

def create_board(board)
  puts board[0..2].join(' | ')
  puts '----------'
  puts board[3..5].join(' | ')
  puts '----------'
  puts board[6..8].join(' | ')
end
#how to win the game -> boolean operator
def win?(board, player)
  if (board[0] == player && board[1] == player && board[2] == player) ||
    (board[3] == player && board[4] == player && board[5] == player) ||
    (board[6] == player && board[7] == player && board[8] == player) ||
    (board[0] == player && board[3] == player && board[6] == player) ||
    (board[1] == player && board[4] == player && board[7] == player) ||
    (board[2] == player && board[5] == player && board[8] == player) ||
    (board[0] == player && board[4] == player && board[8] == player) ||
    (board[2] == player && board[4] == player && board[6] == player)
    puts "Player #{player} has won!"
    return true
  end
  false
end
#how to draw the game -> equal no. of X & 0
def draw? board
  board.each do |e|
    return false if e != 'X' && e != 'O'
  end
  puts 'Draw!'
  true
end

def get_input(board, player)
  puts "Player #{player}, please enter your position [1-9] or enter 'exit' to quit"
  input = gets.chomp
  if input == 'exit'
    puts 'Game exit'
    return 'exit'
  elsif board[input.to_i - 1] == 'X' || board[input.to_i - 1] == 'O'
    puts "This position has been taken. Please select another position"
    get_input board, player
  elsif input.to_i < 1 || input.to_i > 9
    puts 'Invalid position. Please select another position'
    get_input board, player
  else
    board[input.to_i - 1] = player
    create_board board
  end
end

def ai_move(board, player)
  empty_positions = board.each_index.select { |i| board[i] != 'X' && board[i] != 'O' }
  board[empty_positions.sample] = player
  puts 'Computer is thinking...computer has moved.'
  create_board board
end

def versus_human (board, player1, player2)
  create_board board
  loop do
    break if get_input(board, player1) == 'exit'
    break if win?(board, player1) || draw?(board)
    break if get_input(board, player2) == 'exit'
    break if win?(board, player2) || draw?(board)
  end
end

def versus_AI (board, player1, player2)
  puts 'Enter 1 to go first, or 2 to go second.'
  user_selection = gets.chomp.to_i
  if user_selection == 1
    create_board board
    loop do
      break if get_input(board, player1) == 'exit'
      break if win?(board, player1) || draw?(board)
      ai_move(board, player2)
      break if win?(board, player2) || draw?(board)
    end
  elsif user_selection == 2
    loop do
      ai_move(board, player1)
      break if win?(board, player1) || draw?(board)
      break if get_input(board, player2) == 'exit'
      break if win?(board, player2) || draw?(board)
    end
  else
    puts 'Invalid selection. Please try again.'
    versus_AI(board, player1, player2)
  end
end

def start(board, player1, player2)
  puts 'Enter 1 for player vs player'
  puts 'Enter 2 for player vs computer'
  input = gets.chomp
  if input == '1'
    versus_human board, player1, player2
  elsif input == '2'
    versus_AI(board, player1, player2)
  else
    puts 'Invalid selection. Please enter only 1 or 2'
    start(board, player1, player2)
  end
end
#versus_human board, player1, player2
start board, player1, player2
