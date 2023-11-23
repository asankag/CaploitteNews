//
//  ViewController.swift
//  CaploitteNews
//
//  Created by Asanka Gankewala on 11/21/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNametextField: UITextField!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UiChanges()
    }

    @IBAction func forgotButtonPressed(_ sender: UIButton) {
//        UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsName.userArray)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let username = userNametextField.text, username != "" && username.count >= 6 else {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alertsString.userNameOrPasswordNotCorrect), animated: true)
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alertsString.userNameOrPasswordNotCorrect), animated: true)
            return
        }
        
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
            if userArray[index].userName == username {
                // get password
                do {
                    let decryptPassword = try ReUsables.decryptText(encryptedMessage: userArray[index].password ?? "", encryptionKey: Constants.EncryptionKey.encryptionKey)
                    if decryptPassword == password {
                        flg = true
                    }
                } catch {
                    print(error)
                }
            }
        })
        if flg {
            // goto dashboard
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let navController = storyboard.instantiateViewController(withIdentifier: "DashboardNavigationContollerStoryboard") as! UINavigationController
            navController.modalPresentationStyle = .fullScreen

            navController.modalTransitionStyle = .coverVertical//.crossDissolve
            
            self.present(navController, animated: true)
        } else {
            // User not exist
            self.present(ReUsables.showAlert(titel: Constants.Strings.alertsHeader.alertTitel, message: Constants.Strings.alertsString.userNameOrPasswordNotCorrect), animated: true)
        }
    }
    
    func UiChanges () {
        loginButtonOutlet.dropShadow(scale: 25)
        
        userNametextField.setLeftView(image: (UIImage(systemName: "person")!))
        passwordTextField.setLeftView(image: (UIImage(systemName: "lock")!))
    }
}

