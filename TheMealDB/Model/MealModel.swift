//
//  Meal.swift
//  TheMealDB
//
//  Created by mac on 02/08/21.
//

import Foundation

struct MealModel: Codable {
    let meals: [Meals]
}

struct Meals: Codable {
    let strMeal, strMealThumb, idMeal : String
}




