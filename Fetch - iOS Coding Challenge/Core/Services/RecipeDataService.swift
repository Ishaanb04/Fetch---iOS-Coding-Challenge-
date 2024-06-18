//
//  RecipeDataService.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

/// Protocol defining the interface for recipe data service
protocol RecipeDataServiceProtocol {
    /// Fetches all meals
    /// - Returns: An array of `Meal`
    /// - Throws: An error if the fetching or decoding fails
    func fetchAllMeals() async throws -> [Meal]
    
    /// Fetches the image for a meal from a given URL
    /// - Parameter url: The URL of the image
    /// - Returns: An optional `Image` object
    /// - Throws: An error if the fetching or decoding fails
    func fetchImageForMeal(from url: String) async throws -> Image?
    
    /// Fetches the details of a recipe by ID
    /// - Parameter id: The ID of the recipe
    /// - Returns: A `Recipe` object
    /// - Throws: An error if the fetching or decoding fails
    func fetchRecipeDetails(with id: String) async throws -> Recipe
}

/// Class implementing the `RecipeDataServiceProtocol` and providing data service for recipes
class RecipeDataService: RecipeDataServiceProtocol, HTTPDataDownloader {
    // URL for fetching all dessert meals
    private let allMealsUrl = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    // Base URL for fetching recipe details by ID
    private let recipeDetailsBaseURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    // Cache for storing downloaded images
    private let imageCache = ImageCache()
    
    /// Fetches all meals
    /// - Returns: An array of `Meal`
    /// - Throws: An error if the fetching or decoding fails
    func fetchAllMeals() async throws -> [Meal] {
        let mealData = try await getHTTPDecodedData(with: allMealsUrl, as: Meals.self)
        return mealData.allMeals
    }

    /// Fetches the details of a recipe by ID
    /// - Parameter id: The ID of the recipe
    /// - Returns: A `Recipe` object
    /// - Throws: An error if the fetching or decoding fails
    func fetchRecipeDetails(with id: String) async throws -> Recipe {
        let url = recipeDetailsBaseURL + id
        let recipes = try await getHTTPDecodedData(with: url, as: DetailRecipe.self)
        return recipes.recipe[0]
    }

    /// Fetches the image for a meal from a given URL
    /// - Parameter url: The URL of the image
    /// - Returns: An optional `Image` object
    /// - Throws: An error if the fetching or decoding fails
    func fetchImageForMeal(from url: String) async throws -> Image? {
        // Check if the image is already cached
        if let image = imageCache.get(forKey: url) {
            return Image(uiImage: image)
        } else {
            // If not cached, fetch the image from the network
            let imageData = try await getHTTPData(with: url)
            guard let uiImage = UIImage(data: imageData) else { return nil }
            // Cache the fetched image
            imageCache.set(uiImage, for: url)
            return Image(uiImage: uiImage)
        }
    }
}
