//
//  RecipeStepTableView.swift
//  BlueYappron
//
//  Created by Iain Whiteside on 11/27/17.
//  Copyright © 2017 Iain Whiteside. All rights reserved.
//

import UIKit

class RecipeStepTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //override var intrinsicContentSize: CGSize {
      //  return contentSize
    //}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
