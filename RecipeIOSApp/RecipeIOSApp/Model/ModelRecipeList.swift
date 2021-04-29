//
//  ModelRecipeList.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 3/30/21.
//

import Foundation

class ModelRecipeList{
    var title : String = ""
    var id : Int = 0
    var instructions : String = ""
    var ingrediants : String = " "
    
    init(_ title : String, _ id : Int, _ instructions : String, _ ingrediants : String){
        self.title = title
        self.id = id
        self.instructions = instructions
        self.ingrediants = ingrediants
    }
    
    
}
