//
//  RecipeDataService.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

protocol RecipeDataServiceProtocol {
    func fetchAllMeals() async throws -> [Meal]
    func fetchImageForMeal(from url: String) async throws -> Image?
}

struct RecipeDataService: RecipeDataServiceProtocol, HTTPDataDownloader {
    private let allMealsUrl = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"

    func fetchAllMeals() async throws -> [Meal] {
        let mealData = try await getHTTPDecodedData(with: allMealsUrl, as: Meals.self)
        return mealData.allMeals
    }

    func fetchImageForMeal(from url: String) async throws -> Image? {
        let imageData = try await getHTTPData(with: url)
        guard let uiImage = UIImage(data: imageData) else { return nil }
        return Image(uiImage: uiImage)
    }
}
