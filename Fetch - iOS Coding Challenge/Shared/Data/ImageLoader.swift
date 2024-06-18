//
//  ImageLoader.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?

    private let urlString: String
    private let service: RecipeDataServiceProtocol

    init(service: RecipeDataServiceProtocol, url: String) {
        self.service = service
        self.urlString = url
        Task {
            await loadImage()
        }
    }

    @MainActor
    private func loadImage() async {
        do {
            image = try await service.fetchImageForMeal(from: urlString)
        } catch let error as RecipeAPIError {
            image = Image(systemName: "exclamationmark.triangle")
            print("DEBUG: \(error.description)")
        } catch {
            image = Image(systemName: "exclamationmark.triangle")
            print("DEBUG: \(error.localizedDescription)")
        }
    }
}
