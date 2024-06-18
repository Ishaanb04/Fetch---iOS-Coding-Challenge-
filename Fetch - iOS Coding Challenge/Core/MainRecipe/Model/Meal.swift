//
//  Meal.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

struct Meals: Codable, Hashable {
    let allMeals: [Meal]

    enum CodingKeys: String, CodingKey {
        case allMeals = "meals"
    }
}

struct Meal: Codable, Identifiable, Hashable {
    let id: String
    let thumbnailURL: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case thumbnailURL = "strMealThumb"
        case name = "strMeal"
    }
}
