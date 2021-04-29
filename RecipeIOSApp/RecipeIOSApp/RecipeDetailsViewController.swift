//
//  RecipeDetailsViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/21/21.
//

import UIKit
import Firebase

class RecipeDetailsViewController: UIViewController {
    
    var id : Int = 0
    var recipeTitle : String = " "
    var recipeInstructions : String = " "
    var recipeIngrediants : String = " "

    @IBOutlet weak var titleRecipe: UITextView!
    
    @IBOutlet weak var ingrediantsRecipe: UITextView!
    
    @IBOutlet weak var instructionsRecipe: UITextView!
    
    @IBOutlet weak var saveStatus: UILabel!
    
    var db : Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        titleRecipe.text = recipeTitle
        instructionsRecipe.text = recipeInstructions
        ingrediantsRecipe.text = recipeIngrediants
    }
    
   
    @IBAction func saveRecipetoDB(_ sender: Any) {
        let currentUser = Auth.auth().currentUser?.uid
        var uniqueKey : String = ""
        uniqueKey.append(currentUser!)
        uniqueKey.append(String(id))
        
        let docRef = db.collection("SavedRecipeList").document(uniqueKey)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.saveStatus.text = "Already Saved"

            } else {
                print("Document does not exist")
                let newRecord = self.db.collection("SavedRecipeList")
                let recipe = RecipeDetailsDBModel(self.recipeTitle,self.id,self.recipeInstructions, self.recipeIngrediants,currentUser!)
                newRecord.document(uniqueKey).setData([
                                "UniqueId"  : uniqueKey,
                                "RecipeId" : recipe.id,
                                "Title" : recipe.title,
                                "Ingredients" : recipe.ingrediants,
                                "Instructions" : recipe.instructions,
                    "UserId" : currentUser!
                               ])
                
                self.saveStatus.text = "Saved"
                
            }
        }
    }
}
