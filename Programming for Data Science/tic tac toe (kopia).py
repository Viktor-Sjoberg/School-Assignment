import matplotlib.pyplot as plt
import numpy as np

def draw_board(board):
    nrow_board, ncol_board = board.shape
    
    plt.clf()  # Clear the previous plot
    plt.axis('off')
    
    for i in range(1, nrow_board):
        plt.plot([0, ncol_board], [i, i], color="black", linewidth=2)
    
    for i in range(1, ncol_board):
        plt.plot([i, i], [0, nrow_board], color="black", linewidth=2)
    
    for i in range(nrow_board):
        for j in range(ncol_board):
            center_x = j + 0.5
            center_y = nrow_board - i - 0.5
            
            if board[i, j] == 1:
                plt.scatter(center_x, center_y, marker='o', c='blue', s=1000)
            elif board[i, j] == 2:
                plt.scatter(center_x, center_y, marker='x', c='red', s=1000)
    
    plt.pause(0.1)  # Pause to display the plot


def is_box_played(board, row, col):
    return board[row, col] != 0

def check_win(board, player):
    return any(np.sum(board == player, axis=1) == board.shape[1]) or \
           any(np.sum(board == player, axis=0) == board.shape[0]) or \
           np.sum(np.diag(board) == player) == min(board.shape[0], board.shape[1]) or \
           np.sum(np.diag(np.fliplr(board)) == player) == min(board.shape[0], board.shape[1])

def play_game(dimensions):
    if 'x' not in dimensions or not dimensions.replace('x', '').isdigit():
        print("Invalid dimensions format. Use the format 'NxN', e.g., '3x3'.")
        return

    dimensions = list(map(int, dimensions.split('x')))
    if len(dimensions) != 2 or any(map(lambda x: x < 3, dimensions)):
        print("Invalid dimensions. Both dimensions should be at least 3.")
        return

    nrow_board, ncol_board = dimensions

    board = np.zeros((nrow_board, ncol_board))
    draw_board(board)

    print(f"You're playing on a {nrow_board}x{ncol_board} board.")
    print("Player 1 plays with 'Circle' and Player 2 plays with 'Cross'.")

    player = 1
    moves_count = 0

    while True:
        try:
            move = list(map(int, input(f"Player {player}, enter your move (row and column, e.g., 1 1): ").split()))
            if len(move) != 2 or any(map(lambda x: x < 1 or x > min(nrow_board, ncol_board), move)):
                print("Invalid move. Please enter valid row and column numbers.")
                continue
            row, col = move

            if is_box_played(board, row-1, col-1):
                print("You can't play on an already played box. Try again.")
                continue

            board[row-1, col-1] = player
            draw_board(board)

            if check_win(board, player):
                print(f"Player {player} wins!")
                break

            moves_count += 1

            if moves_count == nrow_board * ncol_board:
                print("It's a draw!")
                break

            player = 3 - player  # Switch player (1 -> 2, 2 -> 1)
        except ValueError:
            print("Invalid move. Please enter valid row and column numbers.")


# Example usage
play_game("3x3")  # Play on a 3x3 board
