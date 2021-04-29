//
//  RecipeListViewModel.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 3/30/21.
//

import Foundation
import PromiseKit
import SwiftyJSON

class RecipeListViewModel{
    
    
    func getRecipeList(_ url : String) -> Promise<[ModelRecipeList]> {
        
        return Promise<[ModelRecipeList]>{ seal ->Void in
            
            getAFResponseJSON(url).done { recipeList in
               
              var arr : [ModelRecipeList] = []
                let count = (recipeList["recipes"].count)-1
                
                for recipe in 0...count{
                    
                    var ingrediantList : String = " "
                    
                    let title = recipeList["recipes"][recipe]["title"].stringValue
                    let id = recipeList["recipes"][recipe]["id"].intValue
                    let instructions = recipeList["recipes"][recipe]["instructions"].stringValue
                    let countIngred = recipeList["recipes"][recipe]["extendedIngredients"].count
                    let countI = countIngred-1
                    for ingred in 0...countI {
                        ingrediantList.append(recipeList["recipes"][recipe]["extendedIngredients"][ingred]["name"].stringValue)
                        ingrediantList.append(",")
                    }
                    ingrediantList.removeLast()

                    let listOfRecipe: ModelRecipeList = ModelRecipeList(title,id,instructions,ingrediantList)
                    
                    arr.append(listOfRecipe)
                    
                }

                seal.fulfill(arr)
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
    
}
