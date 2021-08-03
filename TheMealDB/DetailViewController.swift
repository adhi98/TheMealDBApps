//
//  DetailViewController.swift
//  TheMealDB
//
//  Created by mac on 03/08/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var detailMealModel = DetailMealViewModel()
    var mealsData: String?
    @IBOutlet weak var Im_Meals: CustomImage!
    @IBOutlet weak var nameMeals: UILabel!
    @IBOutlet weak var descMeals: UILabel!
    
    @IBOutlet weak var ingr1: UILabel!
    @IBOutlet weak var ingr2: UILabel!
    @IBOutlet weak var ingr3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailMealModel.delegateDetailMeal = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailMealModel.getDetailMeals(id: mealsData!)
    }
}

//MARK: - DetailViewModelDelegate
extension DetailViewController: DetailMealViewModelDelegate {
    func didUpdateDetailMeals(detailMeals: ArrayMealModel) {
        print("test \(detailMeals)")
        DispatchQueue.main.async {
            self.nameMeals.text = detailMeals.strMeal
            self.descMeals.text = detailMeals.strInstructions
            self.ingr1.text = detailMeals.strIngredient1
            self.ingr2.text = detailMeals.strIngredient2
            self.ingr3.text = detailMeals.strIngredient3
            let url = detailMeals.strMealThumb
            self.Im_Meals.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "loading"), options: .highPriority, progress: nil) { (downloadImage, downloadException, cacheType, downloadURL) in
                
            }
        }
    }
    
    func didFailDetailmeal(error: Error) {
        print("error \(error)")
    }
    
    
}
