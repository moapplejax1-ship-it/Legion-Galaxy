import SwiftUI

@main
struct LegionGalaxyApp: App {
    var body: some Scene {
        WindowGroup {
            HomePlanetView()
                .preferredColorScheme(.dark)
        }
    }
}
