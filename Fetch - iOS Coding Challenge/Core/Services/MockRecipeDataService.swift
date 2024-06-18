//
//  MockRecipeDataService.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

class MockRecipeDataService: RecipeDataServiceProtocol {
    var mockData: Data?

    func fetchAllMeals() async throws -> [Meal] {
        do {
            let meals = try JSONDecoder().decode(Meals.self, from: mockData ?? mockAllMealsData)
            return meals.allMeals

        } catch {
            throw RecipeAPIError.unknownError(error: error.localizedDescription)
        }
    }

    func fetchImageForMeal(from url: String) async throws -> Image? {
        return Image(systemName: "exclamationmark.triangle")
    }

    func fetchRecipeDetails(with id: String) async throws -> Recipe {
        return .init(id: "", name: "", instructions: "", thumbnail: "", ingredients: [])
    }
}
