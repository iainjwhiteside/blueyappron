//
//  RecipeStep.swift
//  BlueYappron
//
//  Created by Iain Whiteside on 11/16/17.
//  Copyright © 2017 Iain Whiteside. All rights reserved.
//

import Foundation

class TheRecipeStep {
    
    //MARK: Properties
    
    var ingredients:       [String:String]
    var description:      String
    var time: String

    //MARK: Initialization
    init(ingredients: [String:String], description: String, time: String){
        self.ingredients = ingredients
        self.description = description
        self.time = time
    }
}

