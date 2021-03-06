import Foundation

class Player: NSObject {

    var chip:ChipColor
    
    var ai:AI?
    
    init(chipColor:ChipColor) {
       self.chip = chipColor
    }
    
    init(chipColor: ChipColor, ai: Bool) {
        self.chip = chipColor
        self.ai = AI()
    }
    
    func randomMove(for board: Board) -> Move {
        let column = Int(arc4random_uniform(7))
        if let row = board.nextEmptyRow(at: column) {
          return Move(column: column, row: row)
        } else {
            return randomMove(for: board)
        }
    }
}
