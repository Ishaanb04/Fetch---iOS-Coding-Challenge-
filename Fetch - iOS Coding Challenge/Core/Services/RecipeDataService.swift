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
    func fetchRecipeDetails(with id: String) async throws -> Recipe
}

class RecipeDataService: RecipeDataServiceProtocol, HTTPDataDownloader {
    private let allMealsUrl = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let recipeDetailsBaseURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="

    func fetchAllMeals() async throws -> [Meal] {
        let mealData = try await getHTTPDecodedData(with: allMealsUrl, as: Meals.self)
        return mealData.allMeals
    }

    func fetchRecipeDetails(with id: String) async throws -> Recipe {
        let url = recipeDetailsBaseURL + id
        let recipes = try await getHTTPDecodedData(with: url, as: DetailRecipe.self)
        return recipes.recipe[0]
    }

    func fetchImageForMeal(from url: String) async throws -> Image? {
        if let image = ImageCache.shared.get(forKey: url) {
            print("from cac")
            return Image(uiImage: image)
        } else {
            print("frpm, api")
            let imageData = try await getHTTPData(with: url)
            guard let uiImage = UIImage(data: imageData) else { return nil }
            ImageCache.shared.set(uiImage, for: url)
            return Image(uiImage: uiImage)
        }
    }
}
