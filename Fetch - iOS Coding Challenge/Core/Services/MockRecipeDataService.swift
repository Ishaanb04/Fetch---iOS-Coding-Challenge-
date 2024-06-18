//
//  MockRecipeDataService.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

/// A mock implementation of `RecipeDataServiceProtocol` for testing purposes.
class MockRecipeDataService: RecipeDataServiceProtocol {
    /// Optional mock data for testing.
    var mockData: Data?

    /// Fetches all meals from mock data.
    /// - Returns: An array of `Meal`.
    /// - Throws: An error if the decoding fails.
    func fetchAllMeals() async throws -> [Meal] {
        do {
            // Decode meals from the provided mock data or use default mock data.
            let meals = try JSONDecoder().decode(Meals.self, from: mockData ?? mockAllMealsData)
            return meals.allMeals
        } catch {
            // Throw an error if decoding fails.
            throw RecipeAPIError.unknownError(error: error.localizedDescription)
        }
    }

    /// Returns a placeholder image for a meal.
    /// - Parameter url: The URL of the image (not used in this mock implementation).
    /// - Returns: A system image with an exclamation mark.
    /// - Throws: This function does not throw any errors.
    func fetchImageForMeal(from url: String) async throws -> Image? {
        // Return a placeholder image.
        return Image(systemName: "exclamationmark.triangle")
    }

    /// Fetches recipe details from mock data.
    /// - Parameter id: The ID of the recipe (not used in this mock implementation).
    /// - Returns: A `Recipe` object with empty fields.
    /// - Throws: An error if the decoding fails.
    func fetchRecipeDetails(with id: String) async throws -> Recipe {
        do {
            // Decode recipe details from the provided mock data or use default mock data.
            let recipes = try JSONDecoder().decode(DetailRecipe.self, from: mockData ?? mockRecipeData)
            return recipes.recipe[0]
        } catch {
            // Throw an error if decoding fails.
            throw RecipeAPIError.unknownError(error: error.localizedDescription)
        }
    }
}
