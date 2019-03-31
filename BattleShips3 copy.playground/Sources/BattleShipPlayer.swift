import Foundation

public class BattleShipPlayer: Player {
    public let name: String
    public var field: GameFiled
    
    public init(name: String) {
        self.name = name
        self.field = GameFiled()
        self.field.put_ships_in_random_places()
    }
}

public class BattleShipGameAnnouncer: MultiplayerTurnbasedGameAnnouncer {
    public init(){}
    
    public func lookField(_ players: [Player]) {
        for p in players{
            print(p.name)
            p.field.printField()
            print("")
        }
    }
    
    public func playerAttacking(_ player1: Player,_ player2: Player) {
        print("\(player1.name) attacking \(player2.name)")
    }
    
    public func playerDidEndTurn(_ player: Player) {
        print("\(player.name) ended his turn")
    }
    
    public func playerDidStartTurn(_ player: Player) {
        print("\(player.name) started his turn")
    }
    
    public func gameDidStartTurn(_ game: TurnbasedGame) {
        print("<<<-===->>>")
    }
    
    public func gameDidEnd(_ game: Game) {
        print("The game lasted for \((game as! TurnbasedGame).turns) turns")
    }
    
}

public class DefaultCellDrawer: CellDrawer{
    init() {
    }
}

public class UnusualCellDrawer: CellDrawer{
    init() {
    }
    public func CellToImage (_ cell: CellState) -> String{
        switch cell {
        case CellState.empty:
            return "E"
        case CellState.hit:
            return "D"
        default:
            return "L"
        }
    }
}
