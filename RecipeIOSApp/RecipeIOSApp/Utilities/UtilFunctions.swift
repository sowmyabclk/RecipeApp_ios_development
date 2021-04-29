//
//  UtilFunctions.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 3/30/21.
//

import Foundation

func getRecipeListURL() -> String{
    
    var url = apiURL
    url.append("?rapidapi-key=\(apiKey)")
    url.append("&number=\(randomNumber)")
    return url
}

var userId : String = ""
func saveUserId(_ uid : String) {
    userId = uid
}
