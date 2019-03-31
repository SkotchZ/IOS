import Foundation

// Game

public protocol Game {
    var name: String { get }
    func play()
}

// Delegates

public protocol GameAnnouncer {
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
}

// Default Implementation

extension GameAnnouncer {
    public func gameDidStart(_ game: Game) {
        print("Started a new game of \(game.name)")
    }
    
    public func gameDidEnd(_ game: Game) {
        print("Game ended!")
    }
    
}
