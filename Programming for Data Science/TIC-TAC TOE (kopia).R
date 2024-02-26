# Function to display the Tic-Tac-Toe board with variable dimensions

draw_board <- function(board) {
  nrow_board <- nrow(board)
  ncol_board <- ncol(board)
  
  # Set up the plot with equal cell sizes
  plot(1, type = "n", xlim = c(0, ncol_board), ylim = c(0, nrow_board),
       xlab = "", ylab = "", xaxt = 'n', yaxt = 'n', xaxs = 'i', yaxs = 'i')
  
  # Draw horizontal lines
  for (i in 1:(nrow_board - 1)) {
    y <- i + 0.1
    segments(0, y, ncol_board, y, col = "black", lwd = 2)
  }
  
  # Draw vertical lines
  for (i in 1:(ncol_board - 1)) {
    x <- i + 0.1
    segments(x, 0, x, nrow_board, col = "black", lwd = 2)
  }
  
  for (i in 1:nrow_board) {
    for (j in 1:ncol_board) {
      # Calculate the center position of each cell
      center_x <- j - 0.5
      center_y <- nrow_board - i + 0.5
      
      if (board[i, j] == 1) {
        points(center_x, center_y, pch = 1, cex = 10, col = "blue")
      } else if (board[i, j] == 2) {
        points(center_x, center_y, pch = 4, cex = 10, col = "red")
      }
    }
  }
}

# Function to check if a box has already been played
is_box_played <- function(board, row, col) {
  board[row, col] != 0
}

check_win <- function(board, player, symbols_in_row_to_win) {
  # Check rows
  row_win <- any(rowSums(board == player) >= symbols_in_row_to_win)
  
  # Check columns
  col_win <- any(colSums(board == player) >= symbols_in_row_to_win)
  
  # Check main diagonal
  diag1 <- diag(board)
  diag1_win <- sum(diag1 == player) >= symbols_in_row_to_win
  
  # Check anti-diagonal
  diag2 <- diag(board[, ncol(board):1])
  diag2_win <- sum(diag2 == player) >= symbols_in_row_to_win
  
  return(row_win || col_win || diag1_win || diag2_win)
}

play_game <- function(dimensions, symbols_in_row_to_win) {
  if (!grepl("^\\d+x\\d+$", dimensions)) {
    cat("Invalid dimensions format. Use the format 'NxN', e.g., '3x3'.\n")
    return(NULL)
  }
  
  dimensions <- as.numeric(strsplit(dimensions, "x")[[1]])
  if (length(dimensions) != 2 || any(is.na(dimensions)) || any(dimensions < 3)) {
    cat("Invalid dimensions. Both dimensions should be at least 3.\n")
    return(NULL)
  }
  
  nrow_board <- dimensions[1]
  ncol_board <- dimensions[2]
  
  board <- matrix(0, nrow = nrow_board, ncol = ncol_board)
  draw_board(board)
  
  cat("You're playing on a", nrow_board, "x", ncol_board, "board.\n")
  cat("Player 1 plays with 'Circle' and Player 2 plays with 'Cross'.\n")
  
  player <- 1
  moves_count <- 0
  
  while (TRUE) {
    cat("Player", player, ", enter your move (row and column, e.g., 1 1): ")
    move <- as.numeric(strsplit(readline(), " ")[[1]])
    
    if (length(move) != 2 || any(is.na(move)) || !all(move %in% 1:min(nrow_board, ncol_board))) {
      cat("Invalid move. Please enter valid row and column numbers.\n")
      next
    }
    
    row <- move[1]
    col <- move[2]
    
    if (is_box_played(board, row, col)) {
      cat("You can't   on an already played box. Try again.\n")
      next
    }
    
    board[row, col] <- player
    draw_board(board)
    
    if (check_win(board, player, symbols_in_row_to_win)) {
      cat("Player", player, "wins!\n")
      break
    }
    
    moves_count <- moves_count + 1
    
    if (moves_count == nrow_board * ncol_board) {
      cat("It's a draw!\n")
      break
    }
    
    player <- 3 - player  # Switch player (1 -> 2, 2 -> 1)
  }
}

# Example usage
play_game("4x4", 3)  # Play on a 4x4 board, first player to get 3 in a row wins
  
