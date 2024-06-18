//
//  MainMealView.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct MainMealView: View {
    @StateObject private var imageLoader: ImageLoader
    let meal: Meal

    init(service: RecipeDataServiceProtocol, meal: Meal) {
        self.meal = meal
        self._imageLoader = StateObject(wrappedValue: ImageLoader(service: service, url: meal.thumbnailURL))
    }

    var body: some View {
        VStack {
            if let image = imageLoader.image {
                image
                    .resizable()
                    .mealImageStyle(mealName: meal.name)

            } else {
                ProgressView()
                    .mealImageStyle(mealName: meal.name)
            }
        }
    }
}

#Preview {
    LazyVGrid(columns: [.init(), .init()], content: {
        ForEach(0 ..< 6) { _ in
            MainMealView(service: MockRecipeDataService(), meal: .init(id: "53049", thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", name: "Apam balik"))
        }
    })
}
