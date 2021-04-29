//
//  SignUpViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/21/21.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftSpinner


class SignUpViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var confrimPassword: UITextField!
    
    @IBOutlet weak var labelStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.borderWidth = 0.8
        loginBtn.layer.borderColor = (UIColor( red: 0, green: 0, blue:1, alpha: 1.0 )).cgColor
        
        signUpBtn.layer.borderWidth = 0.8
        signUpBtn.layer.borderColor = (UIColor( red: 0, green: 0, blue:1, alpha: 1.0 )).cgColor

    }
    
    @IBAction func signUpFunc(_ sender: Any) {
    
        let email = emailTxt.text!
        let password = passwordTxt.text!
        let confPassword = confrimPassword.text!

           
           if email.isValidEmail == false{
            labelStatus.text = "Please enter Valid Email Password"
           }
           
           if email.count==0 || password.count==0 || password.count < 6 {
            labelStatus.text = "Please enter Valid Email Password"
           }
        
           if password != confPassword{
             labelStatus.text = "Passwords dont match"
             return
            }
           
           SwiftSpinner.show("Logging in....")
        
           Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (authResult, error1) in
        
            SwiftSpinner.hide()

            
            if error1 != nil{
                self.labelStatus.text = error1?.localizedDescription
                return
            }
            
            let uid = authResult?.user.uid
            saveUserId(uid!)
            self.addkeyChainAfterLogin(uid!)
            self.performSegue(withIdentifier: "dashboardSegue", sender: self)
     }
    }
    
    func addkeyChainAfterLogin(_ uid : String){
        let keyChain = KeyChainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }
    
    @IBAction func alredayHaveAnAccount(_ sender: Any) {
        }

    
    func signUp(){
        Auth.auth().createUser(withEmail: emailTxt.text!, password: passwordTxt.text!) { (authResult, error) in
            if error != nil{
                print("in Error \(error?.localizedDescription)")
                self.labelStatus.text = error?.localizedDescription
                return
            }
            print("in else Error \(error?.localizedDescription)")
            let uid = authResult?.user.uid
            self.addkeyChainAfterLogin(uid!)
           self.performSegue(withIdentifier: "dashboardSegue", sender: self)
    }
    
  }
}
