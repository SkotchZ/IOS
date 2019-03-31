import Foundation

// Game

public protocol MultiplayerGame: Game {
    var players: [Player] { get }
    func join(player: Player)
}

// Delegates

public protocol MultiplayerGameAnnouncer: GameAnnouncer {
    func on_join(_ player: Player, didJoinTheGame game: MultiplayerGame)
}

// Default Implementation

extension MultiplayerGameAnnouncer {
    public func on_join(_ player: Player, didJoinTheGame game: MultiplayerGame) {
        print("\(player.name) has joined the game")
    }
}

public protocol MultiplayerTurnbasedGameAnnouncer: TurnbasedGameDelegate, MultiplayerGameAnnouncer {
    func playerDidStartTurn(_ player: Player)
    func playerDidEndTurn(_ player: Player)
}
