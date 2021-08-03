//
//  File.swift
//  TheMealDB
//
//  Created by mac on 03/08/21.
//

import Foundation
import Alamofire

protocol DetailMealViewModelDelegate {
    func didUpdateDetailMeals(detailMeals: ArrayMealModel)
    func didFailDetailmeal(error: Error)
}

struct DetailMealViewModel {
    let detailMeals = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var delegateDetailMeal: DetailMealViewModelDelegate?
    
    func getDetailMeals(id: String) {
        let url = "\(detailMeals)\(id)"
        print("fullUrl \(url)")
        AF.request(url).responseJSON { (response) in
            switch response.result {
            
            case .success(_):
                if let data = response.data {
                    do{
                        let decodedData = try JSONDecoder().decode(DetailMealData.self, from: data)
                        print("decodedDataMeal \(decodedData.meals[0].strArea!)")
                        self.delegateDetailMeal?.didUpdateDetailMeals(detailMeals: decodedData.meals[0])
                    }catch {
                        print("error decoder")
                    }
                }
            case .failure(let error):
                print("errorGetDetail \(error)")
                self.delegateDetailMeal?.didFailDetailmeal(error: error)
            }
        }
    }
}
