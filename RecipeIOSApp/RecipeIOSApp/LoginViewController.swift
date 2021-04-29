//
//  ViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 3/28/21.
//

import UIKit
import Firebase
import SwiftSpinner

class LoginViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.borderWidth = 0.8
        loginButton.layer.borderColor = (UIColor( red: 0, green: 0, blue:1, alpha: 1.0 )).cgColor
        
        createAccount.layer.borderWidth = 0.8
        createAccount.layer.borderColor = (UIColor( red: 0, green: 0, blue:1, alpha: 1.0 )).cgColor

     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let keyChain = KeyChainService().keyChain
        
        if keyChain.get("uid") != nil{
            performSegue(withIdentifier: "dashboardSegue", sender: self)
        }

    }
    
    @IBAction func createAccountfunc(_ sender: Any) {
          
        }
    
    func addkeyChainAfterLogin(_ uid : String){
        
        let keyChain = KeyChainService().keyChain
        keyChain.set(uid, forKey: "uid")
    }

   
    
    @IBAction func loginFunction(_ sender: Any) {

     let email = txtEmail.text!
        let password = txtPassword.text!
        
        if email.isValidEmail == false{
            lblStatus.text = "Please enter Valid Email Password"
            return
        }
        
        if email.count==0 || password.count==0 || password.count < 6 {
         lblStatus.text = "Please enter Valid Email Password"
            return
        }
        
        SwiftSpinner.show("Logging in....")
        
        Auth.auth().signIn(withEmail: email, password: password) {(result,error) in
            SwiftSpinner.hide()
            if error != nil{
                self.lblStatus.text = error?.localizedDescription
                return
            }
            self.txtPassword.text = ""
            self.lblStatus.text = ""
            let uid = Auth.auth().currentUser?.uid
            saveUserId(uid!)
            self.addkeyChainAfterLogin(uid!)
            self.performSegue(withIdentifier: "dashboardSegue", sender: self)
        

            
       }
    }
}

