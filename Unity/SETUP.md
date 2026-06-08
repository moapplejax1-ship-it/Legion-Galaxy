# Legion Galaxy — Unity Scaffold Setup

This is a **code scaffold**: the C# scripts implement the full data model and screen
logic, recreating the Galaxy-Empire-style dark sci-fi HUD (deep-space backgrounds,
glowing cyan/amber/magenta tech-frame panels, procedurally generated planet sprites).
Scenes, Canvases and prefabs are binary/editor assets, so wire them up in the Unity
Editor as follows (Unity 2022 LTS+, Universal Render Pipeline or built-in, uGUI):

## 1. Project setup
1. Create a new Unity 2D (Mobile) project named `LegionGalaxy`, or open `Unity/LegionGalaxy`.
2. Copy `Assets/Scripts` into your project's `Assets` folder if starting fresh.
3. Switch platform to iOS (and/or Android) in *File > Build Settings*.

## 2. Home Planet scene
1. Create `Scenes/HomePlanet.unity`. Add a `Canvas` (Screen Space – Overlay) + `EventSystem`.
2. Build the layout: header Image (planet sprite), Text for name/progress, a horizontal
   scroll view "resource bar" with badge prefabs, and a vertical scroll view for continents.
3. Create a **ContinentRow prefab**: panel Image + Outline, status icon Image, name Text,
   status Text. Attach `ContinentRowView` and assign references.
4. Add an empty GameObject with `HomePlanetController`, assign the planet graphic Image,
   labels, the continent list parent Transform, and the row prefab.
5. Add a Spaceport button (hooked to `OnOpenSolarSystem`) and a "locked" label, both
   assigned to the controller — the controller toggles them based on `Planet.SpaceportUnlocked`.

## 3. Continent scene
1. Create `Scenes/Continent.unity` with a Canvas, header Text, a vertical list (for
   buildings) and an "invasion panel" (threat label + Launch Invasion button).
2. Create a **BuildingRow prefab** (icon Image, name Text, level Text) with `BuildingRowView`.
3. Add `ContinentController`, assign references, and call `Bind(continent)` from whatever
   navigation code loads this scene (pass the selected `Continent` via a static/service locator
   or a scene-transition payload object).

## 4. Building Detail scene
1. Create `Scenes/BuildingDetail.unity`: icon, name/level/summary Text, an Upgrade button,
   and a roster section (title Text + vertical list).
2. Create a **RosterRow prefab** (name Text, role Text) with `RosterRowView`.
3. Add `BuildingDetailController`, assign references, call `Bind(building)` on load.
   The controller automatically shows the Barracks troop roster (Infantry/Tanks/Mounted
   Units) or Spaceport ship roster (Fighters/Haulers/Cruisers/Probes/Dreadnaughts).

## 5. Solar System scene (presented as an overlay/modal)
1. Create `Scenes/SolarSystem.unity` (or an overlay Canvas loaded additively): header,
   sun graphic, vertical planet list, AgriWorld briefing panel, Close button.
2. Create a **PlanetRow prefab** (panel Image+Outline, planet graphic Image, name Text,
   description Text) with `PlanetRowView`.
3. Add `SolarSystemController`, assign references. It seeds itself from
   `GameWorld.SampleSolarSystem()` in `Start()`.

## 6. Visual styling
`GalaxyTheme` (Assets/Scripts/UI/GalaxyTheme.cs) centralizes the look:
- `StylePanel` / `StyleButton` apply the slate background + glowing colored Outline
  used on every HUD panel and button (swap `Outline` for **TextMeshPro** + a custom
  glow shader/Shader Graph for production-quality bloom).
- `GeneratePlanetTexture` procedurally renders a radial-gradient sphere as placeholder
  planet art — replace with commissioned sprites/3D renders before shipping.
- For the starfield background, add a simple particle system or a tiled scrolling
  star texture behind the Canvas.

## 7. Navigation
Wire scene transitions (or panel show/hide if using a single-scene UI) through a small
`NavigationService`/`UIManager` singleton that passes the selected `Continent` /
`Building` model into the next controller's `Bind(...)` call.

## 8. Next steps
See the project root `DESIGN.md` for the full game design (buildings, troops, ships,
AgriWorld mechanics). From here: replace sample data with persisted game state, add
production/combat tick systems, integrate a multiplayer backend (Photon/Mirror/custom),
and replace placeholder graphics with final art before App Store / Play Store submission.
