//
//  LoginVC.swift
//  ClapChat
//
//  Created by Luke Klepfer on 12/6/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTxtField.delegate = self
        self.passwordTxtField.delegate = self

    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        
        if let email = emailTxtField.text, let password = passwordTxtField.text, (email.characters.count > 0 && password.characters.count > 0 ){
            
            AuthService.instance.login(email: email, pass: password, onComplete: { (errMsg, data) in
                
                guard errMsg == nil else{
                    let alert = UIAlertController(title: "Error Authenticating", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
                
            })
            
        }else{
            let alert = UIAlertController(title: "Email and Password Required", message: "Enter an email and Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}
