//
//  MainRecipeView.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct MainRecipeView: View {
    let service: RecipeDataServiceProtocol
    @StateObject private var viewModel: MainRecipeViewModel

    init(service: RecipeDataServiceProtocol) {
        self.service = service
        self._viewModel = StateObject(wrappedValue: MainRecipeViewModel(service: service))
    }

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    gridView
                        .padding()
                }
                .navigationDestination(for: Meal.self) { meal in
                    DetailRecipeView(service: service, id: meal.id)
                }
            }
            .task {
                await viewModel.fetchMeals()
            }
        }
        .tint(.primary)
    }

    var gridView: some View {
        LazyVGrid(columns: [.init(), .init()], content: {
            ForEach(viewModel.meals) { meal in
                NavigationLink(value: meal) {
                    MainMealView(service: service, meal: meal)
                }
            }
        })
    }
}

#Preview {
    MainRecipeView(service: MockRecipeDataService())
}
