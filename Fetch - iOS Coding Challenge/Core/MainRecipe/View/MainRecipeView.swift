//
//  MainRecipeView.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct MainRecipeView: View {
    @ObservedObject private var vm = MainRecipeViewModel(service: RecipeDataService())
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: [.init(), .init()], content: {
                        ForEach(vm.meals) { meal in
                            MainMealView(service: vm.service, meal: meal)
                        }
                    })
                }
                .padding()
            }
        }
        .task {
            await vm.fetchMeals()
        }
    }
}

#Preview {
    MainRecipeView()
}
