import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Caesar": CaesarCipher(cipherName: "Caesar"),
        "Alpha Numeric": AlphanumericCesarCipher(cipherName: "Alpha Numeric"),
        "Reverse": Reverse(cipherName: "Reverse"),
        "Unicode Number": UnicodeNumber(cipherName: "Unicode Number")
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
