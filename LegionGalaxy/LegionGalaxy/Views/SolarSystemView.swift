import SwiftUI

struct SolarSystemView: View {
    @Environment(\.dismiss) private var dismiss
    private let planets = GameWorld.sampleSolarSystem()

    var body: some View {
        ZStack {
            GalaxyTheme.background
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        Text("SOLAR SYSTEM — KORATH").font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundColor(.white).shadow(color: GalaxyTheme.cyanGlow, radius: 5)
                        Spacer()
                        Button("Close") { dismiss() }.foregroundColor(GalaxyTheme.cyanGlow)
                    }
                    .padding(.top, 12)

                    PlanetGraphic(baseColor: GalaxyTheme.amberGlow, size: 70)
                        .overlay(Image(systemName: "sun.max.fill").foregroundColor(.white).font(.title))

                    ForEach(planets) { planet in
                        PlanetRow(planet: planet)
                    }

                    TechPanel(glow: GalaxyTheme.magentaGlow) {
                        VStack(alignment: .leading, spacing: 6) {
                            Label("AgriWorld Operations", systemImage: "leaf.arrow.circlepath")
                                .font(.headline).foregroundColor(GalaxyTheme.magentaGlow)
                            Text("Send Haulers loaded with Builders, Soldiers, and cargo to Verdant Expanse to establish resource collectors and farms. Aliens escalate their attacks the longer you hold ground there — keep your garrison strong or risk losing the outpost.")
                                .font(.footnote).foregroundColor(.white.opacity(0.7))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
    }
}

private struct PlanetRow: View {
    let planet: Planet

    var body: some View {
        TechPanel(glow: planet.isHome ? GalaxyTheme.cyanGlow : (planet.isAgriWorld ? GalaxyTheme.magentaGlow : GalaxyTheme.amberGlow.opacity(0.5))) {
            HStack(spacing: 14) {
                PlanetGraphic(baseColor: planet.isAgriWorld ? .green : (planet.isHome ? GalaxyTheme.cyanGlow : .gray), size: 50)
                VStack(alignment: .leading, spacing: 3) {
                    Text(planet.name).font(.system(size: 15, weight: .bold, design: .rounded)).foregroundColor(.white)
                    Text(planet.isHome ? "Home Planet" : (planet.isAgriWorld ? "AgriWorld — abundant resources" : "Minor colony opportunity"))
                        .font(.caption).foregroundColor(.white.opacity(0.6))
                }
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(.white.opacity(0.4))
            }
        }
    }
}
