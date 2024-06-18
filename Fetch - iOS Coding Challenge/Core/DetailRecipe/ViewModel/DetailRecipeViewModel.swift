//
//  DetailRecipeViewModel.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

class DetailRecipeViewModel: ObservableObject {
    @Published var recipe: Recipe?
    let service: RecipeDataServiceProtocol
    let id: String
    init(service: RecipeDataServiceProtocol, id: String) {
        self.service = service
        self.id = id
        Task {
            await fetchRecipeDetails()
        }
    }

    @MainActor
    func fetchRecipeDetails() async {
        do {
            recipe = try await service.fetchRecipeDetails(with: id)
        } catch let error as RecipeAPIError {
            print("DEBUG: \(error.description)")
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}

