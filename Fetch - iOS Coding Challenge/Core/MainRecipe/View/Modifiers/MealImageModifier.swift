//
//  MealImageModifier.swift
//  Fetch - iOS Coding Challenge
//
//  Created by Ishaan Bhasin on 6/18/24.
//

import SwiftUI

struct MealImageModifier: ViewModifier {
    let mealName: String

    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(alignment: .bottom) {
                Text(self.mealName)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.bottom)
            }
    }
}

extension View {
    func mealImageStyle(mealName: String) -> some View {
        self.modifier(MealImageModifier(mealName: mealName))
    }
}
