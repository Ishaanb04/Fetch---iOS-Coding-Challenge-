//
//  MainRecipeViewModel.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

class MainRecipeViewModel: ObservableObject {
    @Published var meals: [Meal] = []

    private let service: RecipeDataServiceProtocol

    init(service: RecipeDataServiceProtocol) {
        self.service = service
    }

    @MainActor
    func fetchMeals() async {
        meals = await service.fetchAllMeals()
    }
}
