//
//  Recipe.swift
//  BlueYappron
//
//  Created by Iain Whiteside on 11/15/17.
//  Copyright © 2017 Iain Whiteside. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name:       String
    var photo:      UIImage?
    var serves:     String?
    var time:       String?
    var deets:      String?
    var prep:       [String]?
    var finish:     String?
    var toptionals: String?
    var steps:      [TheRecipeStep]?
 
    //MARK: Initialization
    
    //TODO: Remove this
    init?(name: String, photo: UIImage?){
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
    }
    
    init?(name: String, photo: UIImage?, serves: String?, time:String?,
        deets: String?, prep: [String]?, finish:String?, toptionals: String?, steps: [TheRecipeStep]?) {

        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.serves = serves
        self.time = time
        self.deets = deets
        self.prep = prep
        self.finish = finish
        self.toptionals = toptionals
        self.steps = steps
    }
    
}
