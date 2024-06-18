//
//  RecipeAPIError.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

enum RecipeAPIError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case decodingError
    case unknownError(error: String)

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL recieved"
        case .invalidResponse:
            return "Invalid response recieved"
        case .invalidStatusCode(statusCode: let statusCode):
            return "Invalid status code: (\(statusCode) recieved"
        case .decodingError:
            return "Error Decoding JSON Data"
        case .unknownError(error: let error):
            return "Unknown Error: \(error)"
        }
    }
}
