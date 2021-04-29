//
//  HomePageViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 3/30/21.
//

import UIKit
import Firebase

class HomePageViewController: UIViewController {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var checkRecipeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkRecipeButton.layer.cornerRadius = 6
        favoriteButton.layer.cornerRadius = 6
    }
    
    @IBAction func functionToViewRecipes(_ sender: Any) {

        }
    
    @IBAction func logout(_ sender: Any) {
        do{
            
            try Auth.auth().signOut()
            KeyChainService().keyChain.delete("uid")
            self.performSegue(withIdentifier: "loginPageSegue", sender: self)
            
        }
        catch{
            print(error)
        }
        
    }
    
}
