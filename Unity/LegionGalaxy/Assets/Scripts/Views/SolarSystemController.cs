using UnityEngine;
using UnityEngine.UI;
using LegionGalaxy.Models;
using LegionGalaxy.UI;

namespace LegionGalaxy.Views
{
    /// Drives the Solar System map: lists the 5 planets (home, AgriWorld, minor colonies)
    /// and shows the AgriWorld operations briefing panel.
    public class SolarSystemController : MonoBehaviour
    {
        [Header("Header")]
        public Text systemNameLabel;

        [Header("Planet List")]
        public Transform planetListParent;
        public GameObject planetRowPrefab;

        [Header("AgriWorld Briefing")]
        public Image agriPanelBackground;
        public Outline agriPanelOutline;
        public Text agriBriefingLabel;

        private void Start()
        {
            if (systemNameLabel != null) systemNameLabel.text = "SOLAR SYSTEM — KORATH";

            GalaxyTheme.StylePanel(agriPanelBackground, agriPanelOutline, GalaxyTheme.MagentaGlow);
            if (agriBriefingLabel != null)
                agriBriefingLabel.text =
                    "Send Haulers loaded with Builders, Soldiers, and cargo to Verdant Expanse to " +
                    "establish resource collectors and farms. Aliens escalate their attacks the longer " +
                    "you hold ground there — keep your garrison strong or risk losing the outpost.";

            foreach (Transform child in planetListParent) Destroy(child.gameObject);
            foreach (var planet in GameWorld.SampleSolarSystem())
            {
                var row = Instantiate(planetRowPrefab, planetListParent);
                row.GetComponent<PlanetRowView>()?.Bind(planet);
            }
        }

        public void OnClose()
        {
            // Hook up to your panel-toggling system to return to the Home Planet view.
        }
    }

    /// Bound to the planet row prefab; fills in graphic, name and description.
    public class PlanetRowView : MonoBehaviour
    {
        public Image background;
        public Outline outline;
        public Image planetGraphic;
        public Text nameLabel;
        public Text descriptionLabel;

        public void Bind(Planet planet)
        {
            var glow = planet.IsHome ? GalaxyTheme.CyanGlow
                     : planet.IsAgriWorld ? GalaxyTheme.MagentaGlow
                     : GalaxyTheme.AmberGlow * 0.5f;
            GalaxyTheme.StylePanel(background, outline, glow);

            var baseColor = planet.IsAgriWorld ? Color.green
                          : planet.IsHome ? GalaxyTheme.CyanGlow
                          : Color.gray;
            if (planetGraphic != null)
                planetGraphic.sprite = Sprite.Create(
                    GalaxyTheme.GeneratePlanetTexture(baseColor, 64),
                    new Rect(0, 0, 64, 64), new Vector2(0.5f, 0.5f));

            if (nameLabel != null) nameLabel.text = planet.Name;
            if (descriptionLabel != null)
                descriptionLabel.text = planet.IsHome ? "Home Planet"
                    : planet.IsAgriWorld ? "AgriWorld — abundant resources"
                    : "Minor colony opportunity";
        }
    }
}
