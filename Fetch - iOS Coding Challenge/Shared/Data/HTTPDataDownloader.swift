//
//  HTTPDataDownloader.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

protocol HTTPDataDownloader {}

extension HTTPDataDownloader {
    func getHTTPDecodedData<T: Decodable>(with url: String, as type: T.Type) async throws -> T {
        do {
            let data = try await getHTTPData(with: url)
            let jsonData = try JSONDecoder().decode(type, from: data)
            return jsonData
        } catch {
            throw RecipeAPIError.decodingError
        }
    }

    func getHTTPData(with url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw RecipeAPIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let response = response as? HTTPURLResponse else {
                throw RecipeAPIError.invalidResponse
            }

            guard response.statusCode >= 200, response.statusCode < 300 else {
                throw RecipeAPIError.invalidStatusCode(statusCode: response.statusCode)
            }
            return data
        } catch {
            throw RecipeAPIError.unknownError(error: error.localizedDescription)
        }
    }
}
