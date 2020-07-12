extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
}

extension Character: Strideable {
    public typealias Stride = Int
    
    
    public func distance(to other: Character) -> Character.Stride {
        let stride = Int(String(self).unicodeScalars.first!.value) - Int(String(other).unicodeScalars.first!.value)
        return abs(stride)
    }
    
    public func advanced(by n: Character.Stride) -> Character {
        return Character(UnicodeScalar(String(self).unicodeScalars.first!.value + UInt32(n))!)
    }
}

extension ClosedRange where Element == Character {
    
    var characters: [Character] { return Array(self) }
}


extension String {
    subscript (characterIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: characterIndex)]
    }
}
