//
//  RecipeDataService.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

protocol RecipeDataServiceProtocol {
    func fetchAllMeals() async throws -> [Meal]
}

struct RecipeDataService: RecipeDataServiceProtocol, HTTPDataDownloader {
    private let allMealsUrl = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"

    func fetchAllMeals() async throws -> [Meal] {
        let mealData = try await getHTTPData(with: allMealsUrl, as: Meals.self)
        return mealData.allMeals
    }
}
