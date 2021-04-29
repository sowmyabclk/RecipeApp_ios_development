//
//  RecipeDetailsDBModel.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/22/21.
//

import Foundation

class RecipeDetailsDBModel{
    var title : String = ""
    var id : Int = 0
    var instructions : String = ""
    var ingrediants : String = " "
    var userId : String = " "
    
    init(_ title : String, _ id : Int, _ instructions : String, _ ingrediants : String, _ userId : String){
        self.title = title
        self.id = id
        self.instructions = instructions
        self.ingrediants = ingrediants
        self.userId = userId
    }
}
