import Foundation

public protocol TurnbasedGame: Game {
    var turns: Int { get }
    var hasEnded: Bool { get }
    func start()
    func makeTurn()
    func end()
}

// Default Implementation
extension TurnbasedGame {
    public func play() {
        start()
        while !self.hasEnded {
            makeTurn()
        }
        end()
    }
}

// Delegate

public protocol TurnbasedGameDelegate: GameAnnouncer {
    func gameDidStartTurn(_ game: TurnbasedGame)
    func gameDidEndTurn(_ game: TurnbasedGame)
}

// Default Implementation
extension TurnbasedGameDelegate {
       
    public func gameDidEndTurn(_ game: TurnbasedGame) {
        print("Turn # \((game as! TurnbasedGame).turns) has ended")
    }
    
}




