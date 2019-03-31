import Foundation

public enum CellState: String{
    case empty
    case hit
    case live
}

public class CellCoordinate: Hashable,Equatable{
    var y: Int
    var x: String
    init(x: String, y: Int){
        self.x = x
        self.y = y
    }
    public var hashValue: Int{
        return y.hashValue^x.hashValue
    }
    public static func == (lhs: CellCoordinate, rhs: CellCoordinate) -> Bool {
        return lhs.x==rhs.x && lhs.y==rhs.y
    }
    static func != (lhs: CellCoordinate, rhs: CellCoordinate) -> Bool {
        return !(lhs == rhs)
    }
}

// Delegate

public protocol CellDrawer{
    func CellToImage (_ cell: CellState) -> String
}

extension CellDrawer {
    public func CellToImage (_ cell: CellState) -> String{
        switch cell {
        case CellState.empty:
            return "*"
        case CellState.hit:
            return "X"
        default:
            return "0"
        }
    }
}
