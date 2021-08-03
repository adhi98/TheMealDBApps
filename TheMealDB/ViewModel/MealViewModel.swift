//
//  MealViewModel.swift
//  TheMealDB
//
//  Created by mac on 02/08/21.
//

import Foundation
import Alamofire


// using protocol delegate connect ViewModel to ViewController
protocol MealViewModelDelegate {
    func didUpdateMeals(meals: [Meals])
    func didFailMeals(error: Error)
}

struct MealViewModel {
    
    let urlMeals = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"
    var delegate: MealViewModelDelegate?
    
    func getDataList() {
        AF.request(urlMeals).responseJSON { (response) in
            switch response.result {
            case .success(_):
                if let data = response.data {
                    do {
                        let decodedData = try JSONDecoder().decode(MealModel.self, from: data)
//                        print("decodedData \(decodedData.meals)")
                        self.delegate?.didUpdateMeals(meals: decodedData.meals)
                    }catch {
                        print("error Decoder")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailMeals(error: error)
            }
        }
    }
    
    
    
    
}
