using UnityEngine;
using UnityEngine.UI;
using LegionGalaxy.Models;
using LegionGalaxy.UI;

namespace LegionGalaxy.Views
{
    /// Drives the Home Planet screen: shows the planet graphic, resource bar,
    /// conquest progress, and the list of 5 continents.
    public class HomePlanetController : MonoBehaviour
    {
        [Header("Header")]
        public Image planetGraphic;
        public Text planetNameLabel;
        public Text conquestProgressLabel;

        [Header("Continent List")]
        public Transform continentListParent;
        public GameObject continentRowPrefab;

        [Header("Spaceport")]
        public GameObject spaceportButton;
        public Text spaceportLockedLabel;

        private Planet _planet;

        private void Start()
        {
            _planet = GameWorld.SampleHomePlanet();
            Render();
        }

        private void Render()
        {
            if (planetGraphic != null)
                planetGraphic.sprite = Sprite.Create(
                    GalaxyTheme.GeneratePlanetTexture(GalaxyTheme.CyanGlow),
                    new Rect(0, 0, 128, 128), new Vector2(0.5f, 0.5f));

            if (planetNameLabel != null) planetNameLabel.text = _planet.Name.ToUpper();
            if (conquestProgressLabel != null)
                conquestProgressLabel.text = $"{_planet.ConqueredCount} / 5 Continents Conquered";

            foreach (Transform child in continentListParent) Destroy(child.gameObject);

            foreach (var continent in _planet.Continents)
            {
                var row = Instantiate(continentRowPrefab, continentListParent);
                var rowController = row.GetComponent<ContinentRowView>();
                rowController?.Bind(continent);
            }

            bool unlocked = _planet.SpaceportUnlocked;
            if (spaceportButton != null) spaceportButton.SetActive(unlocked);
            if (spaceportLockedLabel != null)
            {
                spaceportLockedLabel.gameObject.SetActive(!unlocked);
                spaceportLockedLabel.text =
                    $"Conquer 3 of 5 continents to unlock the Spaceport and travel beyond {_planet.Name}.";
            }
        }

        public void OnOpenSolarSystem()
        {
            // Hook up to your scene-loading / panel-toggling system, e.g.:
            // SceneManager.LoadScene("SolarSystem");
        }
    }

    /// Bound to the continent row prefab; fills in the row's name, lock icon and threat label.
    public class ContinentRowView : MonoBehaviour
    {
        public Image background;
        public Outline outline;
        public Image statusIcon;
        public Text nameLabel;
        public Text statusLabel;

        public void Bind(Continent continent)
        {
            GalaxyTheme.StylePanel(background, outline,
                continent.Conquered ? GalaxyTheme.CyanGlow : GalaxyTheme.AmberGlow * 0.5f);

            if (nameLabel != null) nameLabel.text = continent.Name;
            if (statusLabel != null)
                statusLabel.text = continent.Conquered
                    ? "Under your command"
                    : $"Alien presence: {continent.Threat}";
        }
    }
}
