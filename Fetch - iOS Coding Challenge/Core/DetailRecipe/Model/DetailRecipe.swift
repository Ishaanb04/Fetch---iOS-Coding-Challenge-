//
//  DetailRecipe.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import Foundation

struct DetailRecipe: Decodable {
    let recipe: [Recipe]

    enum CodingKeys: String, CodingKey {
        case recipe = "meals"
    }
}

struct Recipe: Decodable {
    let id: String
    let name: String
    let instructions: String
    let thumbnail: String

    let ingredients: [Ingredient]
}

struct Ingredient: Codable, Identifiable {
    var id: String { name }
    let name: String
    let measure: String
}

extension Recipe {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
        case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
    }

    // Custom Decoder for all the ingredients and respective measurement
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        var ingredients: [Ingredient] = []

        for index in 1 ... 10 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(index)")!

            if let ingredientName = try container.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try container.decodeIfPresent(String.self, forKey: measureKey),
               !ingredientName.isEmpty,
               !measure.isEmpty
            {
                let ingredient = Ingredient(name: ingredientName, measure: measure)
                ingredients.append(ingredient)
            }
        }

        self.ingredients = ingredients
    }
}
