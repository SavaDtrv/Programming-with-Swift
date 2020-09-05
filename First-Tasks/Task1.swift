let lowerCaseA:UInt8 = 97
let lowerCaseZ:UInt8 = 122
let capitalA:UInt8 = 65
let capitalZ:UInt8 = 90

func capitalLetter(decodeSymbol:UInt8) -> UInt8 {
    if decodeSymbol < capitalA {
        return (capitalZ - (capitalA - decodeSymbol) + 1)
    } else if decodeSymbol > capitalZ {
        return (capitalA + (decodeSymbol - capitalZ) - 1)
    } else {
        return decodeSymbol
    }
}

func lowerCaseLetter(decodeSymbol:UInt8) -> UInt8 {
    if decodeSymbol < lowerCaseA {
        return (lowerCaseZ - (lowerCaseA - decodeSymbol) + 1)
    } else if decodeSymbol > lowerCaseZ {
        return (lowerCaseA + (decodeSymbol - lowerCaseZ) - 1)
    } else {
        return decodeSymbol
    }
}

func notInRangeOfLetters(stringLetter:UInt8, code:Int) -> UInt8 {
    var decodedSymbol:UInt8

    if code > 0 {
        decodedSymbol = stringLetter - UInt8(code)
    } else {
        decodedSymbol = stringLetter + UInt8(abs(code))
    }
    
    if stringLetter >= capitalA && stringLetter <= capitalZ {
        decodedSymbol = capitalLetter(decodeSymbol:decodedSymbol)
        return decodedSymbol
    } else {
        decodedSymbol = lowerCaseLetter(decodeSymbol:decodedSymbol)
        return decodedSymbol
    }
}

func isLetter(uIntLetter:UInt8) -> Bool {
    return (uIntLetter >= capitalA && uIntLetter <= capitalZ) || (uIntLetter >= lowerCaseA && uIntLetter <= lowerCaseZ)
}

func decodeLetter(letterInUInt:UInt8, code:Int) -> String {
    if isLetter(uIntLetter:letterInUInt) {
        let asciiDecoded = notInRangeOfLetters(stringLetter:letterInUInt, code:code)
        
        let decodedLetter = String(UnicodeScalar(asciiDecoded))
        return decodedLetter
    } else {
        let decodedLetter = String(UnicodeScalar(letterInUInt))
        return decodedLetter
    }
}

func fixCode(code:Int) -> Int {
     return code % 26
}

//the function should decode the string based on the coding strategy descirbed in the task
func decode(in text:String, code: Int) -> String {
    if code == 0 || text == "" {
        return text
    }

    let realCode:Int = fixCode(code:code)
    var decodedString:String = ""

    for strLetter in text.utf8 {
        decodedString += decodeLetter(letterInUInt:strLetter, code:realCode)
    }
    return decodedString
}