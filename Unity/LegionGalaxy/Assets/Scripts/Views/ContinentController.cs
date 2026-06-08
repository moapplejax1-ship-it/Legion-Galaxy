using UnityEngine;
using UnityEngine.UI;
using LegionGalaxy.Models;
using LegionGalaxy.UI;

namespace LegionGalaxy.Views
{
    /// Drives the Continent screen: either the building list (if conquered)
    /// or the alien-invasion panel (if still held by aliens).
    public class ContinentController : MonoBehaviour
    {
        [Header("Header")]
        public Text continentNameLabel;

        [Header("Conquered State")]
        public Transform buildingListParent;
        public GameObject buildingRowPrefab;

        [Header("Unconquered State")]
        public GameObject invasionPanel;
        public Text threatLevelLabel;
        public Image invasionPanelBackground;
        public Outline invasionPanelOutline;

        private Continent _continent;

        /// Call this right after instantiating/loading the screen with the chosen continent.
        public void Bind(Continent continent)
        {
            _continent = continent;
            Render();
        }

        private void Render()
        {
            if (continentNameLabel != null) continentNameLabel.text = _continent.Name.ToUpper();

            bool conquered = _continent.Conquered;
            buildingListParent.gameObject.SetActive(conquered);
            invasionPanel.SetActive(!conquered);

            if (conquered)
            {
                foreach (Transform child in buildingListParent) Destroy(child.gameObject);
                foreach (var building in _continent.Buildings)
                {
                    var row = Instantiate(buildingRowPrefab, buildingListParent);
                    row.GetComponent<BuildingRowView>()?.Bind(building);
                }
            }
            else
            {
                GalaxyTheme.StylePanel(invasionPanelBackground, invasionPanelOutline, GalaxyTheme.AmberGlow);
                if (threatLevelLabel != null) threatLevelLabel.text = $"Threat Level: {_continent.Threat}";
            }
        }

        public void OnLaunchInvasion()
        {
            // Hook up to your combat-resolution system: send Infantry/Tanks/Mounted Units
            // from the Barracks to clear this continent's alien garrison.
        }
    }

    /// Bound to the building row prefab; fills in icon, name and level.
    public class BuildingRowView : MonoBehaviour
    {
        public Image iconImage;
        public Text nameLabel;
        public Text levelLabel;

        public void Bind(Building building)
        {
            if (nameLabel != null) nameLabel.text = BuildingInfo.DisplayName(building.Type);
            if (levelLabel != null) levelLabel.text = $"Level {building.Level}";
            // Assign iconImage.sprite from an icon atlas keyed by building.Type.
        }
    }
}
