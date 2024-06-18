//
//  MainMealView.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct MainMealView: View {
    @ObservedObject private var imageLoader: ImageLoader
    let meal: Meal

    init(service: RecipeDataServiceProtocol, meal: Meal) {
        self.meal = meal
        self.imageLoader = ImageLoader(service: service, url: meal.thumbnailURL)
    }

    var body: some View {
        VStack {
            if let image = imageLoader.image {
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(alignment: .bottom, content: {
                        Text(meal.name)
                            .foregroundStyle(.white)
                            .padding()
                            .background(Color.black.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(.bottom)
                    })

            } else {}
        }
    }
}

#Preview {
    LazyVGrid(columns: [.init(), .init()], content: {
        ForEach(0 ..< 6) { _ in
            MainMealView(service: RecipeDataService(), meal: .init(id: "53049", thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg", name: "Apam balik"))
        }
    })
}
