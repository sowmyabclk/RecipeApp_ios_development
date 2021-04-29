//
//  RecipeViewController.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/21/21.
//

import UIKit

class RecipeViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    

    var recipeListArray : [ModelRecipeList] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        let url = getRecipeListURL()
        print(url)
        
        let recipeModel = RecipeListViewModel()
        recipeModel.getRecipeList(url).done{
            recipes in
                for recipe in recipes {
                        self.recipeListArray.append(recipe)
                }
                self.tableView.reloadData()
            
        }
        .catch { (error) in
                print("Error in getting all the recipes \(error)")
        }

    }
    
        
}

extension RecipeViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeListArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for : indexPath) as? TableViewCellRecipe
        cell?.title.text = recipeListArray[indexPath.row].title
        cell?.cellDelegate = self
        cell?.index = indexPath
       return cell!

    }
    
   
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCellRecipe
        self.performSegue(withIdentifier: "recipeDetails1", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(sender != nil && segue.identifier == "recipeDetails1"){
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationVC = segue.destination as! RecipeDetailsViewController
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
}

extension RecipeViewController: TableViewNew {
    func onClickView(index: Int) {
        print("\(index) is clicked")
    }
}
    
