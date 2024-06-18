//
//  HTTPDataDownloader.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

/// Protocol defining methods for downloading data over HTTP.
protocol HTTPDataDownloader {}

extension HTTPDataDownloader {
    /// Fetches and decodes data from a given URL.
    /// - Parameters:
    ///   - url: The URL string to fetch data from.
    ///   - type: The type to decode the data into.
    /// - Returns: An instance of the specified type.
    /// - Throws: An error if fetching or decoding fails.
    func getHTTPDecodedData<T: Decodable>(with url: String, as type: T.Type) async throws -> T {
        do {
            // Fetch raw data from the URL.
            let data = try await getHTTPData(with: url)
            // Decode the data into the specified type.
            let jsonData = try JSONDecoder().decode(type, from: data)
            return jsonData
        } catch {
            // Throw a decoding error if the process fails.
            throw RecipeAPIError.decodingError
        }
    }

    /// Fetches raw data from a given URL.
    /// - Parameter url: The URL string to fetch data from.
    /// - Returns: The raw data fetched from the URL.
    /// - Throws: An error if fetching fails.
    func getHTTPData(with url: String) async throws -> Data {
        // Validate the URL string.
        guard let url = URL(string: url) else {
            throw RecipeAPIError.invalidURL
        }
        
        do {
            // Perform the data fetch using URLSession.
            let (data, response) = try await URLSession.shared.data(from: url)

            // Validate the HTTP response.
            guard let response = response as? HTTPURLResponse else {
                throw RecipeAPIError.invalidResponse
            }

            // Check the status code for a successful response.
            guard response.statusCode >= 200, response.statusCode < 300 else {
                throw RecipeAPIError.invalidStatusCode(statusCode: response.statusCode)
            }
            
            return data
        } catch {
            // Throw an unknown error if the fetch fails.
            throw RecipeAPIError.unknownError(error: error.localizedDescription)
        }
    }
}
