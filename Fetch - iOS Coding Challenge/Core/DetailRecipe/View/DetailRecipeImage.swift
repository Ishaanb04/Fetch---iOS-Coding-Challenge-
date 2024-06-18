//
//  DetailRecipeImage.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct DetailRecipeImage: View {
    @StateObject private var imageLoader: ImageLoader
    init(service: RecipeDataServiceProtocol, url: String) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(service: service, url: url))
    }

    var body: some View {
        if let image = imageLoader.image {
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        } else {
            ProgressView()
                .scaledToFill()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    DetailRecipeImage(service: MockRecipeDataService(), url: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
}
