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
            Text("Hello World")
        }
        .task {
            await vm.fetchMeals()
        }
    }
}

#Preview {
    MainRecipeView()
}
