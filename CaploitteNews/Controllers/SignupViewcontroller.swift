//
//  SignupViewcontroller.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import Foundation
import UIKit

class SignupViewcontroller: UIViewController {
    
    @IBOutlet weak var createButtonOutlet: UIButton!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UiChanges()
    }
    func UiChanges() {
        userNameTextField.setLeftView(image: (UIImage(systemName: "person")!))
        EmailTextField.setLeftView(image: (UIImage(systemName: "mail")!))
        PhoneNumberTextField.setLeftView(image: (UIImage(systemName: "phone")!))
        passwordTextField.setLeftView(image: (UIImage(systemName: "lock")!))
        reEnterPasswordTextField.setLeftView(image: (UIImage(systemName: "lock")!))
        
        createButtonOutlet.dropShadow(scale: 25)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {

        guard let username = userNameTextField.text, username != "" && username.count >= 6 else {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alerts.userNameIssue), animated: true)
            return
        }
        
        guard let email = EmailTextField.text, isValidEmail(email) else {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alerts.emailIssue), animated: true)
            return
        }
        
        guard let password = passwordTextField.text, isValidPassword(password) else {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alerts.passwordError), animated: true)
            return
        }
        print(password)
        
        guard let reEnterpassword = reEnterPasswordTextField.text, reEnterpassword == password else {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alerts.reEnterPasswordError), animated: true)
            return
        }
        print(reEnterpassword)
        if userExist(userName: username) {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alerts.sameUserExist), animated: true)
        } else {
            var newArray = [User]()
            
            if let savedData = UserDefaults.standard.object(forKey: Constants.UserDefaultsName.userArray) as? Data {
                do {
                    let savedUser = try JSONDecoder().decode([User].self, from: savedData)
                    newArray.append(contentsOf: savedUser)
                } catch {
                    // Failed to convert Data to Contact
                }
            }
            
            do {
                let encryptedPassword = try ReUsables.encryptText(message: password, encryptionKey: Constants.EncryptionKey.encryptionKey)
                
                let userObj = User(userName: username,
                                   email: email,
                                   phoneNumber: PhoneNumberTextField.text,
                                   password: encryptedPassword)
                
                newArray.append(userObj)
            } catch {
                print(error)
            }
            
            UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsName.userArray)
            
            do {
                let encodedData = try JSONEncoder().encode(newArray)
                UserDefaults.standard.set(encodedData, forKey: Constants.UserDefaultsName.userArray)
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            } catch {
                // Failed to encode Contact to Data
            }
        }
    }
    
    func userExist(userName: String) -> Bool {

        var userArray = [User]()
        
        if let savedData = UserDefaults.standard.object(forKey: Constants.UserDefaultsName.userArray) as? Data {
            do {
                let savedUser = try JSONDecoder().decode([User].self, from: savedData)
                userArray.append(contentsOf: savedUser)
            } catch {
                // Failed to convert Data to Contact
            }
        }
        
        var flg = false
        userArray.indices.forEach({ index in
            if userArray[index].userName == userName {
                flg = true
            }
        })
        
        if flg {
            return true
        }
        return false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    public func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}
