import SwiftUI

struct ContinentView: View {
    let continent: Continent

    var body: some View {
        ZStack {
            GalaxyTheme.background
            ScrollView {
                VStack(spacing: 14) {
                    Text(continent.name.uppercased())
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: GalaxyTheme.cyanGlow, radius: 5)
                        .padding(.top, 12)

                    if continent.conquered {
                        ForEach(continent.buildings) { building in
                            NavigationLink {
                                BuildingDetailView(building: building)
                            } label: {
                                BuildingRow(building: building)
                            }
                        }
                    } else {
                        TechPanel(glow: GalaxyTheme.amberGlow) {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Alien Forces Detected", systemImage: "exclamationmark.triangle.fill")
                                    .foregroundColor(GalaxyTheme.amberGlow)
                                    .font(.headline)
                                Text("Threat Level: \(continent.threat.rawValue)")
                                    .foregroundColor(.white.opacity(0.8))
                                Text("Send Infantry, Tanks, and Mounted Units from your Barracks to clear this continent. Conquering it expands your buildable territory — and conquering 3 of 5 unlocks the Spaceport.")
                                    .font(.footnote)
                                    .foregroundColor(.white.opacity(0.6))
                                GalaxyButton(title: "Launch Invasion", glow: GalaxyTheme.amberGlow) {}
                                    .padding(.top, 4)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct BuildingRow: View {
    let building: Building

    var body: some View {
        TechPanel {
            HStack(spacing: 14) {
                Image(systemName: building.type.icon)
                    .font(.title2)
                    .foregroundColor(GalaxyTheme.cyanGlow)
                    .frame(width: 34)
                    .shadow(color: GalaxyTheme.cyanGlow, radius: 4)

                VStack(alignment: .leading, spacing: 3) {
                    Text(building.type.rawValue)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Text("Level \(building.level)")
                        .font(.caption.monospaced())
                        .foregroundColor(GalaxyTheme.amberGlow)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.4))
            }
        }
    }
}
