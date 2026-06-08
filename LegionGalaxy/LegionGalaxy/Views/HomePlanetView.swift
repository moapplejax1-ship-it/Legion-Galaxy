import SwiftUI

struct HomePlanetView: View {
    @State private var planet = GameWorld.sampleHomePlanet()
    @State private var showSolarSystem = false

    var body: some View {
        NavigationView {
            ZStack {
                GalaxyTheme.background

                VStack(spacing: 16) {
                    resourceBar

                    PlanetGraphic(baseColor: GalaxyTheme.cyanGlow, ringColor: GalaxyTheme.amberGlow, size: 150)
                        .padding(.top, 8)

                    Text(planet.name.uppercased())
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: GalaxyTheme.cyanGlow, radius: 6)

                    Text("\(planet.conqueredCount) / 5 Continents Conquered")
                        .font(.subheadline.monospaced())
                        .foregroundColor(GalaxyTheme.amberGlow)

                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(planet.continents) { continent in
                                NavigationLink {
                                    ContinentView(continent: continent)
                                } label: {
                                    ContinentRow(continent: continent)
                                }
                            }

                            if planet.spaceportUnlocked {
                                GalaxyButton(title: "Open Solar System Map", glow: GalaxyTheme.magentaGlow) {
                                    showSolarSystem = true
                                }
                                .padding(.top, 8)
                            } else {
                                Text("Conquer 3 of 5 continents to unlock the Spaceport and travel beyond \(planet.name).")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.6))
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                }
                .padding(.top, 8)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showSolarSystem) {
                SolarSystemView()
            }
        }
        .navigationViewStyle(.stack)
    }

    private var resourceBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ResourceBadge(symbol: "cube.fill", value: "12,400", tint: GalaxyTheme.cyanGlow)
                ResourceBadge(symbol: "leaf.fill", value: "8,250", tint: .green)
                ResourceBadge(symbol: "person.2.fill", value: "3,120", tint: GalaxyTheme.amberGlow)
                ResourceBadge(symbol: "atom", value: "640", tint: GalaxyTheme.magentaGlow)
                ResourceBadge(symbol: "bolt.fill", value: "85", tint: .yellow)
            }
            .padding(.horizontal)
        }
    }
}

private struct ContinentRow: View {
    let continent: Continent

    var body: some View {
        TechPanel(glow: continent.conquered ? GalaxyTheme.cyanGlow : GalaxyTheme.amberGlow.opacity(0.5)) {
            HStack {
                Image(systemName: continent.conquered ? "checkmark.seal.fill" : "lock.fill")
                    .foregroundColor(continent.conquered ? GalaxyTheme.cyanGlow : .white.opacity(0.5))
                    .font(.title3)

                VStack(alignment: .leading, spacing: 3) {
                    Text(continent.name)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text(continent.conquered ? "Under your command" : "Alien presence: \(continent.threat.rawValue)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.4))
            }
        }
    }
}

#Preview {
    HomePlanetView()
}
