using System;
using System.Collections.Generic;
using System.Linq;

namespace LegionGalaxy.Models
{
    public enum BuildingType
    {
        ColonyCenter, ResourceCollector, Barracks, Farm, House,
        ResearchCenter, ExcellorantFactory, Spaceport
    }

    public static class BuildingInfo
    {
        public static string DisplayName(BuildingType t) => t switch
        {
            BuildingType.ColonyCenter => "Colony Center",
            BuildingType.ResourceCollector => "Resource Collector",
            BuildingType.Barracks => "Barracks",
            BuildingType.Farm => "Farm",
            BuildingType.House => "House",
            BuildingType.ResearchCenter => "Research Center",
            BuildingType.ExcellorantFactory => "Excellorant Factory",
            BuildingType.Spaceport => "Spaceport",
            _ => t.ToString()
        };

        public static string Summary(BuildingType t) => t switch
        {
            BuildingType.ColonyCenter => "Core hub of your base. Gates the max level of every other building.",
            BuildingType.ResourceCollector => "Gathers construction materials. Upgrade to increase yield.",
            BuildingType.Barracks => "Trains Infantry, Tanks, and Mounted Units from your population.",
            BuildingType.Farm => "Produces food to sustain and grow your population.",
            BuildingType.House => "Increases population capacity for workers and troops.",
            BuildingType.ResearchCenter => "Unlocks and improves technologies, including ship upgrades.",
            BuildingType.ExcellorantFactory => "Produces Excellorant, a boost resource that speeds up ship factories, barracks, resource collectors, and farms.",
            BuildingType.Spaceport => "Build starships and launch them into your solar system. Unlocked after conquering 3 of 5 continents.",
            _ => ""
        };
    }

    [Serializable]
    public class Building
    {
        public BuildingType Type;
        public int Level = 1;
        public int UpgradeCost => 100 * Level * Level;

        public Building(BuildingType type, int level = 1) { Type = type; Level = level; }
    }

    public enum AlienThreatLevel { Dormant, Guarded, Fortified }

    [Serializable]
    public class Continent
    {
        public string Name;
        public bool Conquered;
        public AlienThreatLevel Threat;
        public List<Building> Buildings = new();

        public Continent(string name, bool conquered, AlienThreatLevel threat, List<Building> buildings = null)
        {
            Name = name; Conquered = conquered; Threat = threat;
            Buildings = buildings ?? new List<Building>();
        }
    }

    [Serializable]
    public class Planet
    {
        public string Name;
        public bool IsAgriWorld;
        public bool IsHome;
        public List<Continent> Continents = new();

        public int ConqueredCount => Continents.Count(c => c.Conquered);
        public bool SpaceportUnlocked => ConqueredCount >= 3;

        public Planet(string name, bool isAgriWorld, bool isHome, List<Continent> continents = null)
        {
            Name = name; IsAgriWorld = isAgriWorld; IsHome = isHome;
            Continents = continents ?? new List<Continent>();
        }
    }

    public enum TroopType { Infantry, Tanks, MountedUnits }

    public static class TroopInfo
    {
        public static string DisplayName(TroopType t) => t switch
        {
            TroopType.Infantry => "Infantry",
            TroopType.Tanks => "Tanks",
            TroopType.MountedUnits => "Mounted Units",
            _ => t.ToString()
        };

        public static string Role(TroopType t) => t switch
        {
            TroopType.Infantry => "All-purpose ground unit",
            TroopType.Tanks => "Defensive specialist (late game)",
            TroopType.MountedUnits => "Fast-attack raider",
            _ => ""
        };
    }

    public enum ShipType { Fighter, Hauler, Cruiser, Probe, Dreadnaught }

    public static class ShipInfo
    {
        public static string Role(ShipType t) => t switch
        {
            ShipType.Fighter => "Cheap and used in large numbers",
            ShipType.Hauler => "Carries cargo and ground units",
            ShipType.Cruiser => "Slower, general-purpose space combat ship",
            ShipType.Probe => "Recon other planets and their surface activity",
            ShipType.Dreadnaught => "Very expensive capital ship for fleet battles",
            _ => ""
        };
    }

    /// Seeds representative game state for the UI scaffold.
    public static class GameWorld
    {
        public static Planet SampleHomePlanet()
        {
            var starterBuildings = new List<Building>
            {
                new(BuildingType.ColonyCenter),
                new(BuildingType.ResourceCollector),
                new(BuildingType.Barracks),
                new(BuildingType.Farm),
                new(BuildingType.House),
                new(BuildingType.ResearchCenter),
                new(BuildingType.ExcellorantFactory)
            };

            var continents = new List<Continent>
            {
                new("Continent I — Aurelia", true, AlienThreatLevel.Dormant, starterBuildings),
                new("Continent II — Voss", false, AlienThreatLevel.Guarded),
                new("Continent III — Kethra", false, AlienThreatLevel.Guarded),
                new("Continent IV — Drannix", false, AlienThreatLevel.Fortified),
                new("Continent V — Solhaven", false, AlienThreatLevel.Fortified)
            };

            return new Planet("New Terra", false, true, continents);
        }

        public static List<Planet> SampleSolarSystem() => new()
        {
            SampleHomePlanet(),
            new Planet("Verdant Expanse", true, false),
            new Planet("Cinder Hollow", false, false),
            new Planet("Glacian Reach", false, false),
            new Planet("Obsidian Drift", false, false)
        };
    }
}
