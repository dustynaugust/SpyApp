import UIKit

class SpyAppViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var secret: UITextField!
    @IBOutlet weak var output: UILabel!

    let factory = CipherFactory()
    var cipher: Cipher?

    @IBAction func encodeButtonPressed(_ sender: UIButton) {
        
        guard
            self.input.text != "",
            self.secret.text != ""
        else {
            output.text = "No input or secret entered."
            return
        }
        if cipher?.cipherName == "Alpha Numeric Ceasar" {
            guard
                // Borrowed from stack overflow user carbonr
                //   https://stackoverflow.com/questions/35992800/check-if-a-string-is-alphanumeric-in-swift
                input.text?.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
                else {
                    output.text = "Must be alpha numeric."
                    return
            }
        }
        
        let plaintext = self.input.text!
        let secretText = self.secret.text!
   
        if let cipher = self.cipher {
            output.text = cipher.encode(plaintext, secret: secretText)
        } else {
            output.text = "No cipher selected"
        }
    }
    @IBAction func decodeButtonPressed(_ sender: Any) {
        
        guard
            self.input.text != "",
            self.secret.text != ""
            else {
                output.text = "No input or secret entered."
                return
        }
        if cipher?.cipherName == "Alpha Numeric Ceasar" {
            guard
                // Borrowed from stack overflow user carbonr
                //   https://stackoverflow.com/questions/35992800/check-if-a-string-is-alphanumeric-in-swift
                input.text?.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil
                else {
                    output.text = "Must be alpha numeric."
                    return
            }
        }
        
        let plaintext = self.input.text!
        let secretText = self.secret.text!
        
        if let cipher = self.cipher {
            output.text = cipher.decrypt(plaintext, secret: secretText)
        } else {
            output.text = "No cipher selected"
        }
        
        
    }
    
    @IBAction func cipherButtonPressed(_ sender: UIButton) {
        guard
            let buttonLabel = sender.titleLabel,
            let buttonText = buttonLabel.text
        else {
            output.text = "No button or no button text"
            return
        }
        
        cipher = factory.cipher(for: buttonText)
        output.text = "\(buttonText) has been selected"
        
    }
}

