import Foundation

public class GameFiled {
    
    var field : [CellCoordinate:CellState] = [CellCoordinate:CellState] ()
    var untouchedCells: [CellCoordinate] = [CellCoordinate] ()
    var drawer: CellDrawer
    init() {
        drawer = DefaultCellDrawer()
        for i in 0..<10{
            for j in "abcdefghij".characters{
                field[CellCoordinate(x: String(j),y: i)]=CellState.empty
                untouchedCells.append(CellCoordinate(x: String(j),y: i))
            }
        }
    }
    
    public func getUntouchedCells () -> [CellCoordinate]{
        return untouchedCells
    }
    
    public func hitCell (cell: CellCoordinate){
        field[cell] = CellState.hit
        untouchedCells = untouchedCells.filter { $0 != cell }
    }
    
    public func HasAliveShip () -> Bool{
        for i in 0..<10{
            for j in "abcdefghij".characters{
                if (field[CellCoordinate(x: String(j),y: i)] == CellState.live){
                    return true
                }
            }
        }
        return false
    }
    
    public func put_ships_in_random_places(){
        let letters = Array("abcdefghij".characters)
        let directions = Array("hv".characters)
        for sheep_length in [4,3,2,1]{
            for _ in  1..<6 - sheep_length{
                var is_placed_correctly = false
                repeat
                {
                    let letter = letters[Int(arc4random_uniform(UInt32(letters.count)))]
                    let direction = directions[Int(arc4random_uniform(UInt32(directions.count)))]
                    let digit = Int(arc4random_uniform(UInt32(letters.count)))
                    is_placed_correctly = is_correct_place_for_ship(cell: CellCoordinate(x: String(letter), y: digit), lenght: sheep_length, direction: direction)
                    if is_placed_correctly{
                        place_ship(cell: CellCoordinate(x: String(letter), y: digit), lenght: sheep_length, direction: direction)
                    }
                }while(!is_placed_correctly)
            }
        }
        printField()
    }
    
    public func printField(){
        for j in "_abcdefghij".characters{
            print(j, terminator:"\t")
        }
        print("")
        for i in 0..<10{
            print(i, terminator:"\t")
            for j in "abcdefghij".characters{
                print(drawer.CellToImage(field[CellCoordinate(x: String(j),y: i)]!), terminator:"\t")
            }
            print("")
        }
    }
    
    private func is_correct_place_for_ship(cell: CellCoordinate, lenght:Int, direction: Character) -> Bool
    {
        var current_cell = cell
        if direction == "h"
        {
            for _ in 1...lenght{
                if !is_free_and_available_cell(current_cell){
                    return false
                }
                current_cell = CellCoordinate (x: nextLetter(current_cell.x)!, y: current_cell.y )
            }
        }
        else
        {
            for _ in 1...lenght{
                if !is_free_and_available_cell(current_cell){
                    return false
                }
                current_cell = CellCoordinate (x: current_cell.x, y: current_cell.y + 1)
            }
        }
        return true
    }
    
    
    private func place_ship(cell: CellCoordinate, lenght:Int, direction: Character)
    {
        var current_cell = cell
        if direction == "h"
        {
            for _ in 1...lenght{
                field[current_cell] = CellState.live
                current_cell = CellCoordinate (x: nextLetter(current_cell.x)!, y: current_cell.y )
            }
        }
        else
        {
            for _ in 1...lenght{
                field[current_cell] = CellState.live
                current_cell = CellCoordinate (x: current_cell.x, y: current_cell.y + 1)
            }
        }
    }
    
    private func is_free_and_available_cell(_ cell: CellCoordinate)->Bool
    {
        if !"abcdefghij".contains(String(cell.x)) || cell.y>10{
            return false
        }
        let prev = prevLetter (cell.x)!
        let next = nextLetter (cell.x)!
        if !"abcdefghij".contains(prev) || !"abcdefghij".contains(next) {
            return false
        }
            for y in [-1,0,1]{
                
                if (field[CellCoordinate(x: cell.x,y: cell.y+y)] != nil) && (field[CellCoordinate(x: cell.x,y: cell.y+y)] != CellState.empty){
                    return false
                }
                if (field[CellCoordinate(x: prev,y: cell.y+y)] != nil) && (field[CellCoordinate(x: prev,y: cell.y+y)] != CellState.empty){
                    return false
                }
                if (field[CellCoordinate(x: next,y: cell.y+y)] != nil) && (field[CellCoordinate(x: next,y: cell.y+y)] != CellState.empty){
                    return false
                }
            }
        
        return true
    }
}
