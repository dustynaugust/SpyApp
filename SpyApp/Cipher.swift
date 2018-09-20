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
        var shiftBy = UInt32(secret)!

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String {
        
        
        
        
        return "Decrypted Cesar"
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
        for (index, character) in upperText.enumerated() {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode
            var shiftedCharacter: String = ""

            for _ in 1 ... secretInt! {
                shiftedUnicode = shiftedUnicode + UInt32(1)
                
                if shiftedUnicode < 48 {
                    shiftedUnicode=48
                }
                
                if shiftedUnicode>57 && shiftedUnicode<65 {
                    shiftedUnicode=65
                }
                
                if shiftedUnicode > 90 {
                        shiftedUnicode = 48
                }
                shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            }
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String {
        return "Decrypted AlphanumericCesar"
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
