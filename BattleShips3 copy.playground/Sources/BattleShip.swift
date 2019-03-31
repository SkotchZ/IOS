import Foundation

public class BattleShips: MultiplayerGame, TurnbasedGame{
    public let name = "BattleShip"
    var curPlayer: Int = 0
    var gameEnd: Bool = false
    public var players: [Player] = [BattleShipPlayer]()
    public var delegate: MultiplayerTurnbasedGameAnnouncer?
    private var numberOfTurns = 0
    
    public init(){
        
    }
    
    public var turns: Int {
        get { return numberOfTurns }
    }
    
    public var hasEnded: Bool {
        get{
            var firstAlive = false
            var winerName=""
            for var p in players
            {
                if firstAlive && p.field.HasAliveShip(){
                    return false
                }
                else if p.field.HasAliveShip(){
                    firstAlive = true
                    winerName = p.name
                }
            }
            print("Winer is \(winerName)")
            return true
        }
    }
    
    public func start() {
        delegate?.gameDidStart(self)
    }
    
    public func end() {
        delegate?.gameDidEnd(self)
    }
    
    public func makeTurn() {
        numberOfTurns += 1
        delegate?.gameDidStartTurn(self)
        for var p1 in players {
            let otherPlayers = players.filter { $0.name != p1.name }
            for var p2 in otherPlayers{
                if self.hasEnded {
                    break
                }
                playerMakeTurn(p1, p2)
            }
        }
        if numberOfTurns % 10 == 0{
            (delegate as! BattleShipGameAnnouncer).lookField(players)
        }
        delegate?.gameDidEndTurn(self)
    }
    
    public func join (player: Player) {
        players.append(player)
        delegate?.on_join(player, didJoinTheGame: self)
    }
    
    public func playerMakeTurn( _ player1: Player,  _ player2: Player){
        delegate?.playerDidStartTurn(player1)
        var cells = player2.field.getUntouchedCells()
        let digit = Int(arc4random_uniform(UInt32(cells.count)))
        (delegate as! BattleShipGameAnnouncer).playerAttacking(player1, player2)
        player2.field.hitCell(cell: cells[digit])
        delegate?.playerDidEndTurn(player1)
    }
}
