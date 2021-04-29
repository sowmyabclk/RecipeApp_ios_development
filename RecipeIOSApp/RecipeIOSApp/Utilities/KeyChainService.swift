//
//  KeyChainService.swift
//  RecipeIOSApp
//
//  Created by Sowmya on 4/19/21.
//

import Foundation
import KeychainSwift

class KeyChainService{
    
    var _localVar = KeychainSwift()
    
    var keyChain : KeychainSwift{
        get{
            return _localVar
        }
        
        set{
            _localVar = newValue
        }
    }
}
