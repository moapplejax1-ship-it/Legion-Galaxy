import SwiftUI

/// Shared visual language: dark-space HUD panels with glowing tech-frame borders,
/// echoing the Galaxy Empire sci-fi UI aesthetic.
enum GalaxyTheme {
    static let spaceBlack = Color(red: 0.04, green: 0.055, blue: 0.10)
    static let panelSlate = Color(red: 0.10, green: 0.13, blue: 0.20).opacity(0.85)
    static let cyanGlow = Color(red: 0.15, green: 0.88, blue: 0.94)
    static let amberGlow = Color(red: 0.94, green: 0.64, blue: 0.15)
    static let magentaGlow = Color(red: 0.78, green: 0.32, blue: 0.95)

    static var background: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.03, green: 0.04, blue: 0.09),
                                    Color(red: 0.07, green: 0.05, blue: 0.14)],
                           startPoint: .top, endPoint: .bottom)
            StarfieldView()
        }
        .ignoresSafeArea()
    }
}

/// Lightweight procedural starfield — random glowing dots over a nebula glow.
struct StarfieldView: View {
    private let stars: [(CGFloat, CGFloat, CGFloat)] = (0..<80).map { _ in
        (CGFloat.random(in: 0...1), CGFloat.random(in: 0...1), CGFloat.random(in: 1...3))
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                RadialGradient(colors: [GalaxyTheme.magentaGlow.opacity(0.18), .clear],
                               center: .topTrailing, startRadius: 10, endRadius: geo.size.width)
                ForEach(0..<stars.count, id: \.self) { i in
                    Circle()
                        .fill(Color.white.opacity(Double.random(in: 0.3...0.9)))
                        .frame(width: stars[i].2, height: stars[i].2)
                        .position(x: stars[i].0 * geo.size.width, y: stars[i].1 * geo.size.height)
                }
            }
        }
    }
}

/// Angular "tech frame" panel used for HUD cards, matching the bracket-cornered
/// glowing borders typical of Galaxy Empire's interface.
struct TechPanel<Content: View>: View {
    var glow: Color = GalaxyTheme.cyanGlow
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(14)
            .background(GalaxyTheme.panelSlate)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(glow.opacity(0.8), lineWidth: 1.5)
                    .shadow(color: glow.opacity(0.6), radius: 4)
            )
    }
}

/// Hexagon/chamfered-corner button matching the angular sci-fi button style.
struct GalaxyButton: View {
    let title: String
    var glow: Color = GalaxyTheme.cyanGlow
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 22)
                .background(
                    ChamferedRectangle(cut: 8)
                        .fill(LinearGradient(colors: [glow.opacity(0.55), glow.opacity(0.18)],
                                             startPoint: .top, endPoint: .bottom))
                )
                .overlay(ChamferedRectangle(cut: 8).stroke(glow, lineWidth: 1.5))
        }
    }
}

struct ChamferedRectangle: Shape {
    var cut: CGFloat
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX + cut, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX - cut, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cut))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX + cut, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cut))
        p.closeSubpath()
        return p
    }
}

/// Glowing badge icon for resources (metal, food, population, research, excellorant).
struct ResourceBadge: View {
    let symbol: String
    let value: String
    let tint: Color

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: symbol)
                .foregroundColor(tint)
                .shadow(color: tint, radius: 3)
            Text(value)
                .font(.system(size: 13, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(GalaxyTheme.panelSlate)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(tint.opacity(0.7), lineWidth: 1))
    }
}

/// Procedural planet sphere — radial gradient sphere with terminator shading,
/// used as a stand-in for commissioned planet art.
struct PlanetGraphic: View {
    var baseColor: Color
    var ringColor: Color? = nil
    var size: CGFloat = 120

    var body: some View {
        ZStack {
            if let ringColor {
                Ellipse()
                    .stroke(ringColor.opacity(0.7), lineWidth: 4)
                    .frame(width: size * 1.7, height: size * 0.5)
                    .rotationEffect(.degrees(-12))
            }
            Circle()
                .fill(RadialGradient(colors: [baseColor.opacity(0.95), baseColor.opacity(0.4), .black.opacity(0.85)],
                                     center: UnitPoint(x: 0.35, y: 0.35),
                                     startRadius: 1, endRadius: size * 0.7))
                .frame(width: size, height: size)
                .overlay(Circle().stroke(baseColor.opacity(0.6), lineWidth: 1))
                .shadow(color: baseColor.opacity(0.5), radius: 12)
        }
    }
}

/// Procedural starship silhouette built from simple chevron shapes — placeholder
/// for future commissioned ship sprites.
struct ShipGraphic: View {
    var tint: Color
    var size: CGFloat = 40

    var body: some View {
        Image(systemName: "paperplane.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(tint)
            .shadow(color: tint, radius: 6)
            .rotationEffect(.degrees(45))
    }
}
