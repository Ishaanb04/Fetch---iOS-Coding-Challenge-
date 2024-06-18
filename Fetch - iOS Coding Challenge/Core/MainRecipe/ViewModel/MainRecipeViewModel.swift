//
//  MainRecipeViewModel.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

class MainRecipeViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String?
    
    let service: RecipeDataServiceProtocol

    init(service: RecipeDataServiceProtocol) {
        self.service = service
    }

    @MainActor
    func fetchMeals() async {
        do {
            meals = try await service.fetchAllMeals()
        } catch let error as RecipeAPIError {
            errorMessage = error.description
            print("DEBUG: \(error.description)")
        } catch {
            errorMessage = error.localizedDescription
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
}
