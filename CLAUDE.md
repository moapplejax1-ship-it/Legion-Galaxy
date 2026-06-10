# Legion Galaxy

Single-file HTML5 browser MMORTS. All code lives in `index.html` (HTML + CSS +
one `<script>`). Develop on branch `claude/exciting-planck-02stom`.

## Testing convention

Extract the script and syntax-check before every commit:

```
python3 -c "import re; s=open('index.html').read(); open('/tmp/g.js','w').write(re.search(r'<script>(.*)</script>', s, re.S).group(1))"
node --check /tmp/g.js
```

For logic changes, run an isolated smoke test by appending test code to the
extracted source and running it via `new Function(src)()` with mocked
`document`, `window`, `localStorage`, `requestAnimationFrame`, etc. Native
`confirm()`/`alert()` are suppressed in the embedded preview — use in-game
modals (`openModal`), never `confirm()`.

## Art direction (REQUIRED for every new asset)

Whenever we design a new visual asset — a unit, building, ship, or icon —
write a **detailed, art-directed image prompt** in Legion Galaxy's house style
so the user can feed it to an external image generator. (No image-generation
tool exists in this environment, so we cannot render the PNG here; we produce
the prompt, the user generates the art, then the `asset-agent` skill embeds
the returned PNG.)

### House style — bake these into every prompt

- **Genre/mood:** dark military sci-fi, grim and industrial, post-war
  frontier. Worn metal, scorched plating, utilitarian — not sleek/clean.
- **Projection:** isometric (2:1 dimetric) for buildings and ground units;
  3/4 top-down for ships. Consistent virtual camera across a set.
- **Palette:** dark desaturated base — gunmetal/charcoal (`#15171c`–`#2a2e36`),
  rust/oxide accents (`#8a4a2a`), steel (`#6a7079`). One faction accent per
  asset when faction-specific:
  - Legion → blood red (`--blood`)
  - Consortium → gold (`--gold`)
  - Synthesis → cold steel/cyan (`--steel`)
- **Lighting:** single key light upper-left, deep ambient shadow, subtle rim
  light. Faint emissive glow only on powered/active elements.
- **Rendering:** crisp pixel/vector-clean edges, no photoreal bloom, no
  lens effects. Transparent background (PNG, alpha). Centered, generous
  margin, no ground shadow baked in (game adds its own).
- **Output spec:** state target size in the prompt (building tiles ~64px,
  unit/ship icons ~48px) — never render larger than displayed; see
  `asset-agent.md`.

Each prompt should specify: subject + silhouette, materials/wear, the
isometric/top-down framing, the palette + any faction accent, lighting,
transparent background, and target resolution.

## Specialist skills (`.claude/skills/`)

- `asset-agent` — embed user-supplied PNGs into the single file (base64).
- `content-agent` — add buildings/research/ships/troops following data tables.
- `balance-agent` — tune economy/combat/research numbers.
- `ui-agent`, `qa-agent` — UI work and validation.
