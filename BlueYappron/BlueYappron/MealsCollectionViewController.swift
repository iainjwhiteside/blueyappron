//
//  MealsCollectionViewController.swift
//  BlueYappron
//
//  Created by Iain Whiteside on 12/5/17.
//  Copyright © 2017 Iain Whiteside. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MealsCollectionViewController: UICollectionViewController {

    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "CollectionCellShowRecipe":
            guard let mealDetailViewController = segue.destination as? RecipeViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealCollectionViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = collectionView?.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return meals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "MealCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! MealCollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.black
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.layer.bounds
        gradientLayer.colors = [(UIColor(white: 0.0, alpha: 0).cgColor),(UIColor(white: 0.0, alpha: 1).cgColor )]
        gradientLayer.locations = [0.5, 1]
        //gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi , 0, 0, 1)
        //If you want to have a border for this layer also
        //gradientLayer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        //gradientLayer.borderWidth = 1
        cell.BackgroundImage.layer.addSublayer(gradientLayer)

        
        let meal = meals[indexPath.row]
        cell.BackgroundImage.image = meal.photo
        cell.MealNameLabel.text = meal.name
        
        return cell
    }

   
    func processVintageImage(_ image: UIImage) -> UIImage {
        
        guard let inputImage = CIImage(image: image) else { return image }
        //let centerVector = [CIVector vectorWithX:150 Y:150];
        guard
            let vignetteFilter = CIFilter(name: "CIVignette",
                withInputParameters: ["inputImage": inputImage,
                "inputRadius" : 0.25, "inputIntensity" : 1.0]),
            let vignetteFilterOutput = vignetteFilter.outputImage
        else { return image }
        
        let context = CIContext(options: nil)
        
        let cgImage = context.createCGImage(vignetteFilterOutput, from: inputImage.extent)
        
    
        return UIImage(cgImage: cgImage!)
    }
    
  
    private func loadSampleMeals() {
        
       
        
        let photo1 = processVintageImage(UIImage(named: "Frittata")!)
//        let photo2 = processVintageImage(UIImage(named: "Zesty")!)
//        let photo3 = processVintageImage(UIImage(named: "Paella")!)
//        let photo4 = processVintageImage(UIImage(named: "Tagine")!)
//        let photo5 = processVintageImage(UIImage(named: "Pasta")!)
//        let fajitaphoto = processVintageImage(UIImage(named: "Fajita")!)
//        let vegphoto = processVintageImage(UIImage(named: "veg")!)
//
      //  let photo1 = UIImage(named: "Frittata")
        let photo2 = UIImage(named: "Zesty")
       // let photo3 = UIImage(named: "Paella")
        //let photo4 = UIImage(named: "Tagine")
        let photo5 = UIImage(named: "Pasta")
        let fajitaphoto = UIImage(named: "Fajita")
        let vegphoto = UIImage(named: "veg")
        let pastaStep1Ingreds = ["Whole wheat pasta":"6 cups"]
        let pastaStep2Ingreds = ["Oil":"Glug"]
        let pastaStep3Ingreds = ["White onion":"1/2, diced",
                                 "Garlic":"2 cloves, minced",
                                 "Dried sage & Red pepper flakes (optional)":"1 dash each"
        ]
        let pastaStep4Ingreds = ["Milk (almond)":"1 1/2 cups",
                                 "Pumpkin puree":"1 can",
                                 "Nutmeg":"1/4 tsp",
                                 "Salt, pepper":"To taste"]
        
        let step1 = TheRecipeStep(ingredients: pastaStep1Ingreds, description: "Boil in pot until al dente", time: "10 min")
        let step2 = TheRecipeStep(ingredients: pastaStep2Ingreds, description: "Heat in pan", time: "1 min")
        let step3 = TheRecipeStep(ingredients: pastaStep3Ingreds, description: "Cook in oil (stirring occasionally) until onions are soft", time: "10 min")
        let step4 = TheRecipeStep(ingredients: pastaStep4Ingreds, description: "Add to pot, stir until creamy sauce forms", time: "3 min")
        
        let pastaSteps = [step1,step2,step3,step4]
        
        guard let meal0 = Meal(
            name: "Pumpkin Sage Pasta",
            photo: photo5,
            serves: "4",
            time: "30 min",
            deets: "Pot + Pan",
            prep: ["Boil water, dice ½ onion & 2 cloves garlic"],
            finish: "Combine cooked pasta with sauce.",
            toptionals: "parmesan, pumpkin seeds, sage leaves",
            steps: pastaSteps
            )else {
                fatalError("Unable to instantiate meal0")
        }
        
        let fajitaStep1Ingreds = ["Wild rice":"2 cups"]
        let fajitaStep2Ingreds = ["Salt, pepper, cumin, garlic powder, paprika":"1/2 tsp each"]
        let fajitaStep3Ingreds = ["Bell peppers":"4, sliced",
                                  "White onion":"1, sliced",
                                  "Chicken breast":"4 small"  ]
        let fstep1 = TheRecipeStep(ingredients: fajitaStep1Ingreds, description: "Boil in 5 cups water", time: "40 min")
        let fstep2 = TheRecipeStep(ingredients: fajitaStep2Ingreds, description: "Combine in small bowl", time: "")
        let fstep3 = TheRecipeStep(ingredients: fajitaStep3Ingreds, description: "Place on tray, sprinkle with oil then with spice mixture.", time: "")
        let fSteps = [fstep1,fstep2,fstep3]
        guard let mealfajita = Meal(
            name: "Chicken Fajita Bowl",
            photo: fajitaphoto,
            serves: "4",
            time: "40 min",
            deets: "Pot + Baking Tray",
            prep: ["Turn oven to 400°","Cut 4 bell peppers & 1 onion into slices"],
            finish: "Bake at 400° for 20 min and serve with rice.",
            toptionals: "avocado, black beans, corn, cilantro",
            steps: fSteps
            )else {
                fatalError("Unable to instantiate meal0")
        }
        let vStep1Ingreds = ["Brussel sprouts":"2lb, halved",
                             "White onion":"1, diced",
                             "Salt, Pepper":"Dash",
                             "Olive oil":"Glug"
        ]
        let vstep1 = TheRecipeStep(ingredients: vStep1Ingreds, description: "Coat sprouts and onion in oil, salt and pepper on tray.", time: "")
        let vStep2Ingreds = ["Pears":"3, in wedges"]
        let vstep2 = TheRecipeStep(ingredients: vStep2Ingreds, description: "Place on tray and bake.", time: "25 min")
        let vStep3Ingreds = ["Lemon":"1, for juice",
                             "Honey":"Drizzling",
                             "Dried Cranberries":"Handful"]
        let vstep3 = TheRecipeStep(ingredients: vStep3Ingreds, description: "Place on tray and bake.", time: "25 min")
        let vegSteps = [vstep1,vstep2,vstep3]
        
        guard let mealveg = Meal(
            name: "Autumn Veg Bake",
            photo: vegphoto,
            serves: "4",
            time: "50 min",
            deets: "Pot + pan",
            prep: ["Turn over to 450°; line tray with parchment","Halve 2 lbs brussel sprouts, wedge 3 pears, dice 1 onion"],
            finish: "Take out of the oven and munch.",
            toptionals: "goats cheese, sesame seeds",
            steps: vegSteps
            )else {
                fatalError("Unable to instantiate meal0")
        }
        
        let fritStep1Ingreds = ["Eggs":"8",
                                "Milk":"1/4 cup",
                                "Salt, Pepper":"Pinch each"
        ]
        let fritstep1 = TheRecipeStep(ingredients: fritStep1Ingreds, description: "Whisk in a bowl.", time: "5 min")
        
        let fritStep2Ingreds = ["Spinach":"3 cups"]
        let fritstep2 = TheRecipeStep(ingredients: fritStep2Ingreds, description: "Saute in pan until it starts to wilt.", time: "2 min")
        
        let fritStep3Ingreds = ["Egg mixture":"All",
                                "Chopped herbs":"All"
        ]
        let fritstep3 = TheRecipeStep(ingredients: fritStep3Ingreds, description: "Add to pan of spinach and stir well.", time: "2 min")
        
        let fritStep4Ingreds = ["Chopped Tomatoes":"All",
                                "Goat cheese":"1 cup"]
        let fritstep4 = TheRecipeStep(ingredients: fritStep4Ingreds, description: "Space tomatoes evenly and crumble cheese on top. Reduce heat to medium and cover, flipping after ~6 min", time: "~6 min per side")
        
        let fritSteps = [fritstep1,fritstep2,fritstep3,fritstep4]
        guard let meal1 = Meal(
            name: "Fancy Frittata",
            photo: photo1,
            serves: "2",
            time: "25 min",
            deets: "Bowl, Whisk + Pan",
            prep:["Pre-heat broiler on Hi", "Halve 1 cup grape tomatoes","Finely chop one bunch each of basil and dill"],
            finish: "Place ~6 inches from broiler, until golden, ~2 min",
            toptionals: "Extra basil and dill",
            steps: fritSteps
            ) else {
                fatalError("Unable to instantiate meal1")
        }
        
        let zestStep1Ingreds = ["Cous cous":"2 cups"]
        let zeststep1 = TheRecipeStep(ingredients: zestStep1Ingreds, description: "Add to pot with 4 cups boiling water.  Simmer on medium heat.", time: "15 min")
        
        let zestStep2Ingreds = ["Olive oil":"Glug",
                                "Chopped asparagus + zucchini":"All",
                                ]
        let zeststep2 = TheRecipeStep(ingredients: zestStep2Ingreds, description: "Heat oil then add asparagus and zucchini, keeping separate, sauté until brown. Set zucchini aside and add asparagus to cous cous pan.", time: "10 min")
        
        let zestStep3Ingreds = ["Chopped onion":"1 onion",
                                "Minced garlic":"3 cloves",
                                ]
        let zeststep3 = TheRecipeStep(ingredients: zestStep3Ingreds, description: "Add onion to now empty pan and stir. After ~4 min, add garlic for 2 min", time: "6 min")
        
        let zestStep4Ingreds = ["Cooked cous cous and asparagus":"All, sans water"
        ]
        let zeststep4 = TheRecipeStep(ingredients: zestStep4Ingreds, description: "Drain excess liquid and add to the pan", time: "")
        let zestSteps = [zeststep1,zeststep2,zeststep3,zeststep4]
        
        guard let meal2 = Meal(
            name: "Zesty Salad",
            photo: photo2,
            serves: "4",
            time:"25 min",
            deets: "Pot, Pan, Zester",
            prep:["Bring 4 cups water to boil",
                  "Dice 1 onion, chop asparagus bunch into 1 inch",
                  "Chop zucchini into 1/2 inch rounds",
                  "Zest and halve one lemon"],
            finish: "Add zucchini, lemon, and parmesan, and stir well",
            toptionals: "walnuts",
            steps: zestSteps) else {
                fatalError("Unable to instantiate meal3")
        }
        
//        guard let meal3 = Meal(name: "Paella", photo: photo3) else {
//            fatalError("Unable to instantiate meal3")
//        }
//
//        guard let meal4 = Meal(name: "Apricot Tagine", photo: photo4) else {
//            fatalError("Unable to instantiate meal4")
//        }
        
        meals += [meal0,mealfajita,mealveg,meal1, meal2]//, meal3, meal4]
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
   
}

extension MealsCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
