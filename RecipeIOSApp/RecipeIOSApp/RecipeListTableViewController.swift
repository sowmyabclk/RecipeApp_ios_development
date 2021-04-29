//
//  RecipeListTableViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 3/30/21.
//

import UIKit
import Firebase


class RecipeListTableViewController: UITableViewController {
    
    
    var recipeListArray : [RecipeDetailsDBModel] = []

    var db : Firestore!


    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        let currentUser = Auth.auth().currentUser?.uid

        db.collection("SavedRecipeList").whereField( "UserId", isEqualTo: currentUser! ).getDocuments() { (querySnapshot, err) in
                   if err != nil {
                    print("Error getting documents: \(String(describing: err))");

                       return
                   }
                   
                   self.recipeListArray.removeAll()
                   
                   for document in querySnapshot!.documents{

                    let title = document.data()["Title"] as! String
                    let id = document.data()["RecipeId"]  as! Int
                    let instructions = document.data()["Instructions"] as! String
                    let ingrediants = document.data()["Ingredients"] as! String
                       
                    
                    let listOfRecipee: RecipeDetailsDBModel = RecipeDetailsDBModel(title,id,instructions,ingrediants,currentUser!)
                    
                    self.recipeListArray.append(listOfRecipee)
                       
                   }
            self.tableView.reloadData()

               }

    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipeListArray.count
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("UserRecipeTableViewCell", owner: self, options:nil)?.first as! UserRecipeTableViewCell
        let text = (self.recipeListArray[indexPath.row])
        cell.userRecipeTitle.text = self.recipeListArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell = tableView.cellForRow(at: indexPath) as? UserRecipeTableViewCell
       self.performSegue(withIdentifier: "UserRecipeDetailsSegue", sender: cell)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(sender != nil && segue.identifier == "UserRecipeDetailsSegue"){
           if let indexPath = tableView.indexPathForSelectedRow{
               let destinationVC = segue.destination as! UserDetailsPageViewController
               let id = recipeListArray[indexPath.row].id
               let title = recipeListArray[indexPath.row].title
               let instructions = recipeListArray[indexPath.row].instructions
               let ingrediants = recipeListArray[indexPath.row].ingrediants
               destinationVC.id = id
               destinationVC.recipeTitle = title
               destinationVC.recipeIngrediants = ingrediants
               destinationVC.recipeInstructions = instructions
           }
           
           
           
       }
   }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = recipeListArray[indexPath.row].id
        let currentUser = Auth.auth().currentUser?.uid
        let uniqueId = currentUser!+String(id)
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            db.collection("SavedRecipeList").document(uniqueId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    self.db.collection("SavedRecipeList").whereField( "UserId", isEqualTo: currentUser! ).getDocuments() { (querySnapshot, err) in
                               if err != nil {
                                print("Error getting documents: \(String(describing: err))");

                                   return
                               }
                               
                               self.recipeListArray.removeAll()
                               
                               for document in querySnapshot!.documents{

                                   let title = document.data()["Title"] as! String
                                let id = document.data()["RecipeId"]  as! Int
                                let instructions = document.data()["Instructions"] as! String
                                let ingrediants = document.data()["Ingredients"] as! String
                                   
                                
                                let listOfRecipee: RecipeDetailsDBModel = RecipeDetailsDBModel(title,id,instructions,ingrediants,currentUser!)
                                
                                self.recipeListArray.append(listOfRecipee)
                                   
                               }
                        self.tableView.reloadData()

                           }
                }
            }
            
        }
    }
    

}


