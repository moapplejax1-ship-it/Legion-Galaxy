import Foundation

enum BuildingType: String, CaseIterable, Identifiable {
    case colonyCenter = "Colony Center"
    case resourceCollector = "Resource Collector"
    case barracks = "Barracks"
    case farm = "Farm"
    case house = "House"
    case researchCenter = "Research Center"
    case excellorantFactory = "Excellorant Factory"
    case spaceport = "Spaceport"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .colonyCenter: return "building.columns.fill"
        case .resourceCollector: return "cube.fill"
        case .barracks: return "shield.lefthalf.filled"
        case .farm: return "leaf.fill"
        case .house: return "house.fill"
        case .researchCenter: return "atom"
        case .excellorantFactory: return "bolt.fill"
        case .spaceport: return "airplane.departure"
        }
    }

    var summary: String {
        switch self {
        case .colonyCenter: return "Core hub of your base. Gates the max level of every other building."
        case .resourceCollector: return "Gathers construction materials. Upgrade to increase yield."
        case .barracks: return "Trains Infantry, Tanks, and Mounted Units from your population."
        case .farm: return "Produces food to sustain and grow your population."
        case .house: return "Increases population capacity for workers and troops."
        case .researchCenter: return "Unlocks and improves technologies, including ship upgrades."
        case .excellorantFactory: return "Produces Excellorant, a boost resource that speeds up ship factories, barracks, resource collectors, and farms."
        case .spaceport: return "Build starships and launch them into your solar system. Unlocked after conquering 3 of 5 continents."
        }
    }
}

struct Building: Identifiable {
    let id = UUID()
    let type: BuildingType
    var level: Int

    var upgradeCost: Int { 100 * level * level }
}

enum AlienThreatLevel: String {
    case dormant = "Dormant"
    case guarded = "Guarded"
    case fortified = "Fortified"
}

struct Continent: Identifiable {
    let id = UUID()
    let name: String
    var conquered: Bool
    var threat: AlienThreatLevel
    var buildings: [Building]
}

struct Planet: Identifiable {
    let id = UUID()
    let name: String
    let isAgriWorld: Bool
    let isHome: Bool
    var continents: [Continent]

    var conqueredCount: Int { continents.filter(\.conquered).count }
    var spaceportUnlocked: Bool { conqueredCount >= 3 }
}

enum TroopType: String, CaseIterable {
    case infantry = "Infantry"
    case tanks = "Tanks"
    case mounted = "Mounted Units"

    var icon: String {
        switch self {
        case .infantry: return "person.fill"
        case .tanks: return "shield.fill"
        case .mounted: return "hare.fill"
        }
    }

    var role: String {
        switch self {
        case .infantry: return "All-purpose ground unit"
        case .tanks: return "Defensive specialist (late game)"
        case .mounted: return "Fast-attack raider"
        }
    }
}

enum ShipType: String, CaseIterable {
    case fighter = "Fighter"
    case hauler = "Hauler"
    case cruiser = "Cruiser"
    case probe = "Probe"
    case dreadnaught = "Dreadnaught"

    var role: String {
        switch self {
        case .fighter: return "Cheap and used in large numbers"
        case .hauler: return "Carries cargo and ground units"
        case .cruiser: return "Slower, general-purpose space combat ship"
        case .probe: return "Recon other planets and their surface activity"
        case .dreadnaught: return "Very expensive capital ship for fleet battles"
        }
    }
}

/// Sample game-state factory used to seed the UI with representative data.
enum GameWorld {
    static func sampleHomePlanet() -> Planet {
        let starterBuildings: [Building] = [
            Building(type: .colonyCenter, level: 1),
            Building(type: .resourceCollector, level: 1),
            Building(type: .barracks, level: 1),
            Building(type: .farm, level: 1),
            Building(type: .house, level: 1),
            Building(type: .researchCenter, level: 1),
            Building(type: .excellorantFactory, level: 1)
        ]
        let continents = [
            Continent(name: "Continent I — Aurelia", conquered: true, threat: .dormant, buildings: starterBuildings),
            Continent(name: "Continent II — Voss", conquered: false, threat: .guarded, buildings: []),
            Continent(name: "Continent III — Kethra", conquered: false, threat: .guarded, buildings: []),
            Continent(name: "Continent IV — Drannix", conquered: false, threat: .fortified, buildings: []),
            Continent(name: "Continent V — Solhaven", conquered: false, threat: .fortified, buildings: [])
        ]
        return Planet(name: "New Terra", isAgriWorld: false, isHome: true, continents: continents)
    }

    static func sampleSolarSystem() -> [Planet] {
        [
            sampleHomePlanet(),
            Planet(name: "Verdant Expanse", isAgriWorld: true, isHome: false, continents: []),
            Planet(name: "Cinder Hollow", isAgriWorld: false, isHome: false, continents: []),
            Planet(name: "Glacian Reach", isAgriWorld: false, isHome: false, continents: []),
            Planet(name: "Obsidian Drift", isAgriWorld: false, isHome: false, continents: [])
        ]
    }
}
