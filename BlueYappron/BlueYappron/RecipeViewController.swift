//
//  ViewController.swift
//  BlueYappron
//
//  Created by Iain Whiteside on 11/15/17.
//  Copyright © 2017 Iain Whiteside. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource{
   // @IBOutlet weak var servesLabel: UILabel!
    
    //@IBOutlet weak var deetsLabel: UILabel!
    //@IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var prepLabel: UILabel!
    //@IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeStepTable: UITableView!
    //@IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toptionalsLabel: UILabel!
    //@IBOutlet weak var toptionalLabel: UILabel!
    var meal: Meal?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal {
                        navigationItem.title = meal.name
            titleLabel.text = meal.name.uppercased()
            prepLabel.text   = getMealPrep(prep: meal.prep!)
            //recipeImage.image = meal.photo
            finishLabel.text = meal.finish
            toptionalsLabel.text = meal.toptionals
            //servesLabel.text = "SERVES " + meal.serves!.uppercased()
            //timeLabel.text = meal.time?.uppercased()
            //deetsLabel.text = meal.deets?.uppercased()
            
        }
        
        recipeStepTable.rowHeight = UITableViewAutomaticDimension
        recipeStepTable.estimatedRowHeight = 100
        recipeStepTable.sizeToFit()
        recipeStepTable.contentInset =  UIEdgeInsetsMake(10, 12, 0, 0)
  recipeStepTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: recipeStepTable.frame.size.width, height: 1))
    }
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        DispatchQueue.main.async {
            self.recipeStepTable.sizeToFit()
         // self.heightConstraint.constant = self.recipeStepTable.intrinsicContentSize.height
        self.heightConstraint.constant = self.recipeStepTable.contentInset.top
            + self.recipeStepTable.contentInset.top
            + self.recipeStepTable.contentSize.height //random.
        self.recipeStepTable.layoutIfNeeded()
        }
    }
    private func getMealPrep(prep: [String]) -> String{
        
        if(prep.count > 1){
            var fullString = ""
            for string: String in prep {
                let bulletPoint: String = "- "
                let formattedString: String = "\(bulletPoint) \(string)\n"
                fullString = fullString + formattedString
                        }
            return fullString
        }
        
        if(prep.count == 1){
            return prep[0]
        } else{
            return "Cool! No preparation necessary!"
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (meal!.steps?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "recipeStepCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeStepTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RecipeStepTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        if let meal = meal {
            let step = meal.steps![indexPath.row]
            let ingreds=getIngreds(step: step)
            let quantities=getQuantities(step: step)
            cell.ingredLabel.text = ingreds
            cell.quantityLabel.text = quantities
            cell.descriptionLabel.text = step.description
            //cell.imageView?.frame = CGRectOffset(cell.frame, 10, 10)
        }
        return cell
    }
    
    
    private func getIngreds(step: TheRecipeStep) -> String{
        var fullString = ""
        
        for string: String in step.ingredients.keys
        {
            let bulletPoint: String = ""
            let formattedString: String = "\(bulletPoint) \(string)\n\n"
            
            fullString = fullString + formattedString
        }
        let truncated = String(fullString.dropLast().dropLast())
        return truncated
    }
    private func getQuantities(step: TheRecipeStep) -> String{
        var fullString = ""
        
        for string: String in step.ingredients.values
        {
            let bulletPoint: String = ""
            let formattedString: String = "\(bulletPoint) \(string)\n\n"
            
            fullString = fullString + formattedString
        }
        let truncated = String(fullString.dropLast().dropLast())
        return truncated
    }
}

