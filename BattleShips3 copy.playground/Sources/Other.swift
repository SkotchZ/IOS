import Foundation

public func nextLetter(_ letter: String) -> String? {
    
    // Check if string is build from exactly one Unicode scalar:
    guard let uniCode = UnicodeScalar(letter) else {
        return nil
    }
    switch uniCode {
    case "a" ..< "z":
        return String(UnicodeScalar(uniCode.value + 1)!)
    default:
        return nil
    }
}

public func prevLetter(_ letter: String) -> String? {
    
    // Check if string is build from exactly one Unicode scalar:
    guard let uniCode = UnicodeScalar(letter) else {
        return nil
    }
    switch uniCode {
    case "a" ..< "z":
        return String(UnicodeScalar(uniCode.value - 1)!)
    default:
        return nil
    }
}
