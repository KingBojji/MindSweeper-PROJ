import Foundation

class AI: NSObject {
    
    static let depth = 2
    
    func score(for board: Board) -> Int {
        
        if board.activePlayer === board.player {
            if board.isWinnerBoard(for: board.activePlayer.chip, connections: 4){
                return 10
            }
            
            
        } else if board.activePlayer === board.opponent {
            if board.isWinnerBoard(for: board.activePlayer.chip, connections: 4) {
                return -10
            }
            
        }
        
        return 0
    }
    
    func minimaxStrategy(board: Board, depth: Int, isMax: Bool) -> Int {
        
        let scr = score(for: board)
        
        if depth == 0 {
            return 0
        }
        
        if scr == 10 || scr == -10 {
            return scr
        }
        if board.areMovesLeft() == false {
            return 0
        }
        
        if isMax {
            var bestScore = -10000
            
            for col in 0 ..< Board.width {
                
                if let row = board.nextEmptyRow(at: col) {
                    board.spots[col][row] = board.activePlayer.chip
                    board.swapTurn()
                    
                    bestScore = max(bestScore, minimaxStrategy(board: board, depth: depth - 1, isMax: !isMax))
                    
                    board.spots[col][row] = .none
                    
                }
            }
            
            return bestScore
            
        }
        else {
            
            var bestScore = 10000
            
            for col in 0 ..< Board.width {
                if let row = board.nextEmptyRow(at: col) {
                    board.spots[col][row] = board.activePlayer.chip
                    
                    board.swapTurn()
                    bestScore = min(bestScore, minimaxStrategy(board: board, depth: depth - 1, isMax: !isMax))
                    
                    board.spots[col][row] = .none
                }
            }
            
            return bestScore
            
        }
        
    }
    
    func findBestMove(for board: Board) -> Move? {
        var bestScore = 0
        var bestMove:Move
        
        let boardCopy = Board(playerColor: board.player.chip, gameMode: .onePlayer)
        boardCopy.spots = board.spots
        
        for col in 0 ..< Board.width {
            if let row = boardCopy.nextEmptyRow(at: col) {
                
                boardCopy.spots[col][row] = boardCopy.activePlayer.chip
                let moveScore = minimaxStrategy(board: boardCopy, depth: AI.depth, isMax: false)
                
                if moveScore != bestScore {
                    bestMove = Move(column: col, row: row)
                    bestScore = moveScore
                    
                    return bestMove
                }
            }
        }
        
        return nil
    }
    
}
