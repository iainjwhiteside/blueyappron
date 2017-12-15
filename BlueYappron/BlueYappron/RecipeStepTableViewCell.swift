//
//  RecipeStepTableViewCell.swift
//  BlueYappron
//
//  Created by Iain Whiteside on 11/17/17.
//  Copyright © 2017 Iain Whiteside. All rights reserved.
//

import UIKit

class RecipeStepTableViewCell: UITableViewCell {
    

    //MARK: Properties
    @IBOutlet weak var ingredLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    // Inside UITableViewCell subclass
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let f = contentView.frame
//        let fr = UIEdgeInsetsInsetRect(f, UIEdgeInsetsMake(10, 10, 10, 10))
//        contentView.frame = fr
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
