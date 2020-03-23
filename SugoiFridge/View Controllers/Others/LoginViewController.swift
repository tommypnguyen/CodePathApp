//
//  LoginViewController.swift
//  SugoiFridge
//
//  Created by Angelo Domingo on 3/15/20.
//  Copyright © 2020 TAR. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeLoginButton()
        // customizeTextFields()
    }
    
    func customizeLoginButton() {
        loginButton.layer.cornerRadius = CGFloat(CustomUI.cornerRadius.rawValue)
    }
    
    func customizeTextFields() {
        usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Light Pink") as Any])
        
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Light Pink") as Any])
    }
    
    
    // MARK: - User Action
    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription ?? "Login Error")")
            }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        print(password)
        
        PFUser.logInWithUsername(inBackground: username, password: password)
            { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription ?? "Login Error")")
            }
        }
    }
}
