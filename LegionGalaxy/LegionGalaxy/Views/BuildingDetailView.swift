import SwiftUI

struct BuildingDetailView: View {
    let building: Building

    var body: some View {
        ZStack {
            GalaxyTheme.background
            ScrollView {
                VStack(spacing: 16) {
                    Image(systemName: building.type.icon)
                        .font(.system(size: 56))
                        .foregroundColor(GalaxyTheme.cyanGlow)
                        .shadow(color: GalaxyTheme.cyanGlow, radius: 10)
                        .padding(.top, 20)

                    Text(building.type.rawValue.uppercased())
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)

                    Text("Level \(building.level)")
                        .font(.headline.monospaced())
                        .foregroundColor(GalaxyTheme.amberGlow)

                    TechPanel {
                        Text(building.type.summary)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    GalaxyButton(title: "Upgrade — \(building.upgradeCost) Materials") {}

                    if building.type == .barracks {
                        unitSection(title: "Trainable Units", names: TroopType.allCases.map { ($0.rawValue, $0.icon, $0.role) })
                    }
                    if building.type == .spaceport {
                        unitSection(title: "Buildable Ships", names: ShipType.allCases.map { ($0.rawValue, "paperplane.fill", $0.role) })
                    }
                }
                .padding()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func unitSection(title: String, names: [(String, String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.caption.bold())
                .foregroundColor(GalaxyTheme.magentaGlow)
                .frame(maxWidth: .infinity, alignment: .leading)

            ForEach(names, id: \.0) { name, icon, role in
                TechPanel(glow: GalaxyTheme.magentaGlow.opacity(0.6)) {
                    HStack(spacing: 12) {
                        Image(systemName: icon)
                            .foregroundColor(GalaxyTheme.magentaGlow)
                            .frame(width: 28)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(name).foregroundColor(.white).font(.system(size: 14, weight: .bold))
                            Text(role).foregroundColor(.white.opacity(0.6)).font(.caption)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
