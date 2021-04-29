//
//  UserDetailsPageViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/23/21.
//

import UIKit
import Firebase

class UserDetailsPageViewController: UIViewController {
    
    var id : Int = 0
    var recipeTitle : String = " "
    var recipeInstructions : String = " "
    var recipeIngrediants : String = " "
    
    var db : Firestore!
    
    
    @IBOutlet weak var userRecipeTitle: UITextView!
    
    @IBOutlet weak var userRecipeIngredients: UITextView!
    
    @IBOutlet weak var userRecipeInstructions: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        userRecipeTitle.text = recipeTitle
        userRecipeIngredients.text = recipeIngrediants
        userRecipeInstructions.text = recipeInstructions

    }
    
}
