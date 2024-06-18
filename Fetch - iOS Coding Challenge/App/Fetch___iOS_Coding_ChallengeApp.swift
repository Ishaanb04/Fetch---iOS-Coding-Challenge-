// ___FILEHEADER___

import SwiftUI

@main
struct Fetch___iOS_Coding_ChallengeApp: App {
    let service = RecipeDataService()
    var body: some Scene {
        WindowGroup {
            MainRecipeView(service: service)
        }
    }
}
