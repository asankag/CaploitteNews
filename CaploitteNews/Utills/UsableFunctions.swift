//
//  UsableFunctions.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import Foundation
import UIKit
import RNCryptor

class ReUsables : NSObject{
    
    static func showAlert(titel: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    static func encryptText(message: String, encryptionKey: String) throws -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }
    
    static func decryptText(encryptedMessage: String, encryptionKey: String) throws -> String {
        
        let encryptedData = Data.init(base64Encoded: encryptedMessage)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!

        return decryptedString
    }
}
