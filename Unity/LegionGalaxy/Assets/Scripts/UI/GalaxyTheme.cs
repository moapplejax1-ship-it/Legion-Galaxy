using UnityEngine;
using UnityEngine.UI;

namespace LegionGalaxy.UI
{
    /// Shared visual constants and helpers that recreate the Galaxy-Empire-style
    /// dark sci-fi HUD look: deep-space backgrounds, glowing cyan/amber tech-frame
    /// panels, and angular chamfered buttons.
    public static class GalaxyTheme
    {
        public static readonly Color SpaceBlack = new(0.04f, 0.055f, 0.10f);
        public static readonly Color PanelSlate = new(0.10f, 0.13f, 0.20f, 0.85f);
        public static readonly Color CyanGlow = new(0.15f, 0.88f, 0.94f);
        public static readonly Color AmberGlow = new(0.94f, 0.64f, 0.15f);
        public static readonly Color MagentaGlow = new(0.78f, 0.32f, 0.95f);

        /// Applies the standard glowing tech-panel look to an Image (background + outline).
        public static void StylePanel(Image background, Outline outline, Color? glow = null)
        {
            var glowColor = glow ?? CyanGlow;
            if (background != null) background.color = PanelSlate;
            if (outline != null)
            {
                outline.effectColor = glowColor;
                outline.effectDistance = new Vector2(1.5f, -1.5f);
            }
        }

        /// Applies the angular button look (gradient-ish fill via color + glowing outline).
        public static void StyleButton(Image fill, Outline outline, Color? glow = null)
        {
            var glowColor = glow ?? CyanGlow;
            if (fill != null) fill.color = Color.Lerp(glowColor, Color.black, 0.55f);
            if (outline != null)
            {
                outline.effectColor = glowColor;
                outline.effectDistance = new Vector2(1.5f, -1.5f);
            }
        }

        /// Generates a simple radial-gradient sphere texture as a stand-in for
        /// commissioned planet art (used by PlanetGraphic).
        public static Texture2D GeneratePlanetTexture(Color baseColor, int size = 128)
        {
            var tex = new Texture2D(size, size, TextureFormat.RGBA32, false);
            var center = new Vector2(size * 0.35f, size * 0.65f);
            float maxDist = size * 0.7f;

            for (int y = 0; y < size; y++)
            {
                for (int x = 0; x < size; x++)
                {
                    float dist = Vector2.Distance(new Vector2(x, y), center);
                    float distFromMid = Vector2.Distance(new Vector2(x, y), new Vector2(size / 2f, size / 2f));

                    Color pixel;
                    if (distFromMid > size / 2f)
                    {
                        pixel = Color.clear;
                    }
                    else
                    {
                        float t = Mathf.Clamp01(dist / maxDist);
                        pixel = Color.Lerp(baseColor, Color.black, t * t);
                        pixel.a = 1f;
                    }
                    tex.SetPixel(x, y, pixel);
                }
            }
            tex.Apply();
            return tex;
        }
    }
}
