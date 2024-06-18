//
//  DetailRecipeView.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct DetailRecipeView: View {
    let id: String
    let service: RecipeDataServiceProtocol
    @StateObject private var viewModel: DetailRecipeViewModel

    init(service: RecipeDataServiceProtocol, id: String) {
        self.id = id
        self.service = service
        self._viewModel = StateObject(wrappedValue: DetailRecipeViewModel(service: service, id: id))
    }

    var body: some View {
        VStack {
            if let recipe = viewModel.recipe {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        DetailRecipeImage(service: service, url: recipe.thumbnail)
                            .frame(height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.bottom, 20)

                        Text(recipe.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)

                        Text("Instructions")
                            .font(.headline)
                            .padding(.bottom, 5)

                        Text(recipe.instructions)
                            .font(.body)
                            .padding(.bottom, 20)

                        Text("Ingredients")
                            .font(.headline)
                            .padding(.bottom, 5)

                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(recipe.ingredients) { ingredient in
                                HStack {
                                    Text(ingredient.name)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Text(ingredient.measure)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                ProgressView()
            }
        }
        .navigationBarTitle("Recipe Details", displayMode: .inline)
    }
}

#Preview {
    DetailRecipeView(service: RecipeDataService(), id: "53049")
}
