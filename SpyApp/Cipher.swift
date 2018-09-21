import Foundation

protocol Cipher {
    var cipherName: String { get }
    func encode(_ plaintext: String, secret: String) -> String
    func decrypt(_ plaintext: String, secret: String) -> String
}

struct CaesarCipher: Cipher {
    var cipherName: String
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        
        let shiftByInt = Int(secret)
        var shiftBy = UInt32(secret)
        
        
        
        
        if shiftByInt! > 0 {
            for character in plaintext {
                let unicode = character.unicodeScalars.first!.value
                let shiftedUnicode = unicode + shiftBy!
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                encoded = encoded + shiftedCharacter
            }
            
        } else if shiftByInt! < 0 {
            return "Axel you didn't ask us to deal with a negative input... sorry!"
            
        } else {
            return plaintext
        }
        
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decrypted = ""
        
        let shiftByInt = Int(secret)
        var shiftBy = UInt32(secret)
            
            if shiftByInt! > 0 {
                for character in plaintext {
                    let unicode = character.unicodeScalars.first!.value
                    let shiftedUnicode = unicode - shiftBy!
                    let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                    decrypted = decrypted + shiftedCharacter
                }
                
            } else if shiftByInt! < 0 {
                return "Axel you didn't ask us to deal with a negative input... sorry!"
                
            } else {
                return plaintext
            }
        return decrypted
    }
}

struct AlphanumericCesarCipher: Cipher {
    var cipherName: String
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        let secretInt = Int.init(secret)
        let upperText = plaintext.uppercased()
        
        
        // Transverse the plaintext
        // Shift until problematic Then adjust appropriately
        for (_, character) in upperText.enumerated() {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode
            var shiftedCharacter: String = ""
            
            if secretInt! > 0 {
                
                shiftedCharacter = shiftCharForward(&shiftedUnicode, shiftByInt: secretInt!)
                encoded = encoded + shiftedCharacter
                
            } else if secretInt! < 0 {
                shiftedCharacter = shiftCharBackward(&shiftedUnicode, shiftByInt: secretInt!)
                encoded = encoded + shiftedCharacter
            } else {
                return plaintext
            }
        }
        
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String {
        
        var decrypted = ""
        let secretInt = Int.init(secret)
        let upperText = plaintext.uppercased()
        
        
        for (index, character) in upperText.enumerated() {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode
            var shiftedCharacter: String = ""
            
            if secretInt! > 0 {
                shiftedCharacter = shiftCharBackward(&shiftedUnicode, shiftByInt: secretInt!)
                decrypted = decrypted + shiftedCharacter
                
            } else if secretInt! < 0 {
                shiftedCharacter = shiftCharForward(&shiftedUnicode, shiftByInt: secretInt!)
                decrypted = decrypted + shiftedCharacter
            } else {
                return plaintext
            }
        }
        
        return decrypted
    }
    
    private func shiftCharForward (_ shiftedUnicode: inout UInt32, shiftByInt: Int) -> String {
        var shiftedChar = ""
        
        for _ in 1 ... abs(shiftByInt) {
            shiftedUnicode = shiftedUnicode + UInt32(1)
            
            // 9 maps to A
            if shiftedUnicode>57 && shiftedUnicode<65 {
                shiftedUnicode=65
            }
            
            // Z maps to 0
            if shiftedUnicode > 90 {
                shiftedUnicode = 48
            }
            shiftedChar = String(UnicodeScalar(UInt8(shiftedUnicode)))
        }
        
        return shiftedChar
    }
    
    private func shiftCharBackward(_ shiftedUnicode: inout UInt32, shiftByInt: Int) -> String {
        var shiftedChar = ""
        
        for _ in 1 ... abs(shiftByInt) {
            shiftedUnicode = shiftedUnicode - UInt32(1)
            
            // A maps to 9
            if shiftedUnicode>57 && shiftedUnicode<65 {
                shiftedUnicode=57
            }
            
            // 0 maps to Z
            if shiftedUnicode < 48 {
                shiftedUnicode = 90
            }
            shiftedChar = String(UnicodeScalar(UInt8(shiftedUnicode)))
        }
        
        return shiftedChar
    }
}

struct Reverse: Cipher {
    var cipherName: String
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = secret
        for (index, char) in plaintext.reversed().enumerated() {
            encoded.append(char)
            encoded.append(secret)
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decrypted = String(plaintext.reversed())
        decrypted = decrypted.replacingOccurrences(of: secret, with: "")
        return decrypted
    }
}

struct UnicodeNumber: Cipher {
    var cipherName: String
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = "\(secret)::"
        
        for character in plaintext {
            let unicodeChar = character.unicodeScalars.first!.value
            encoded.append(String(unicodeChar))
            encoded.append("%")
        }
        
        return encoded
    }
    
    // Still needs some input checking for the format to be correct
    // Helped from here https://www.dotnetperls.com/convert-int-character-swift
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decrypted = ""
        
        var componentsArray = plaintext.components(separatedBy: "::") // CHANGE TO PLAINTEXT
        let encodedUnicode = componentsArray[1]
        let unicodeArray = encodedUnicode.components(separatedBy: "%")
        
        for unicodeChar in unicodeArray {
            if unicodeChar == "" {
                break
            }
            let intVal = Int(unicodeChar)
            let unicodeScalarValue = UnicodeScalar(intVal!)
            decrypted+=String(unicodeScalarValue!)
            print(decrypted)
        }
        return decrypted
    }
}
