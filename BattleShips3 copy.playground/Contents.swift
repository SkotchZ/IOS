//: Playground - noun: a place where people can play

import UIKit

let game = BattleShips()
game.delegate = BattleShipGameAnnouncer()
//
for name in ["Ivan", "Sergey"] {
    game.join(player: BattleShipPlayer(name: name))
}

game.play()
