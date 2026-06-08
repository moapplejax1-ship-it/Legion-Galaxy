# Legion Galaxy — Game Design Document

MMORTS for iOS/Android, inspired by *Galaxy Empire* (2011), built toward an eventual Apple Store release.

## Visual / UI Language (Galaxy Empire–style)
- Deep-space dark backgrounds (near-black navy `#0A0E1A`) with starfield + nebula gradients (cyan/purple/orange glows)
- HUD panels: semi-transparent dark slate panels with glowing cyan (`#27E0F0`) or amber (`#F0A427`) borders, beveled corner brackets (sci-fi "tech frame" look)
- Buttons: angular hexagon/chamfered-corner shapes with gradient fill + glow-on-press
- Typography: bold condensed sci-fi style headers, clean sans body text
- Iconography: simple glyph icons for resources (metal, food, population, research, excellorant) rendered as glowing badges
- Planets/ships rendered as procedurally drawn radial-gradient spheres + simple vector silhouettes (placeholder for future commissioned art / Apple Store assets)

## Core Loop
Home Planet (5 continents, start with 1) → build & upgrade base → train troops → conquer continents from aliens → unlock Spaceport → build ships → expand to Solar System (5 planets incl. AgriWorld) → defend growing alien attacks → expand further.

## Planet & Continents
- Each planet has 5 continents; player starts controlling 1
- Conquering continents = defeating resident alien forces with trained troops
- Each conquered continent expands buildable area
- Conquering 3/5 continents unlocks Spaceport construction

## Base Buildings (upgradeable, each with level-based stat curves)
| Building | Function |
|---|---|
| Colony Center | Core hub; gates max level of other buildings |
| Resource Collector | Gathers construction materials (metal/ore) |
| Barracks | Trains troops, consumes population & food |
| Farm | Produces food (caps population growth) |
| House | Increases population capacity |
| Research Center | Unlocks/improves technologies |
| Excellorant Factory | Produces Excellorant — a boost resource that speeds up ship factories, barracks, resource collectors, and farms (usable in small or large batches) |
| Spaceport | (unlocked at 3/5 continents) builds and launches starships |

## Barracks Units
- **Infantry** — all-purpose ground unit
- **Tanks** — defensive specialist (late game)
- **Mounted Units** — fast-attack raiders

## Spaceport Ships
- **Fighters** — cheap, swarm in numbers
- **Haulers** — transport troops/builders/cargo between planets
- **Cruisers** — slower, general-purpose combat vessel
- **Probes** — recon enemy planets/surfaces
- **Dreadnaughts** — very expensive capital ships for large fleet battles

## Research Center Tech Trees
- **Ships**: hull/health upgrades, weapon upgrades, speed upgrades
- (Expandable trees for ground units, economy, and defense planned for later milestones)

## Solar System Layer
- 5 planets per solar system, one is an **AgriWorld** (resource-rich)
- Haulers ferry soldiers/builders/cargo to AgriWorld to build collectors & farm resources
- Presence on a world draws escalating alien attacks — sustained defense required or the outpost falls
- Smaller colonies can be founded on the remaining worlds for modest resource trickle

## Progression Summary
1. Build economy (Resource Collector, Farm, House, Excellorant Factory)
2. Train troops in Barracks
3. Conquer continents (defeat aliens) → expand buildable space
4. Reach 3/5 continents → unlock Spaceport
5. Build ships → launch into Solar System
6. Establish AgriWorld outpost & secondary colonies → defend against escalating alien waves
7. Research Center unlocks stronger ships/units to sustain expansion
