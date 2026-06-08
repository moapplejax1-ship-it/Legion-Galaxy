using UnityEngine;
using UnityEngine.UI;
using LegionGalaxy.Models;

namespace LegionGalaxy.Views
{
    /// Drives the Building Detail screen: shows level, summary, upgrade button,
    /// and — for Barracks/Spaceport — the trainable units / buildable ships roster.
    public class BuildingDetailController : MonoBehaviour
    {
        [Header("Header")]
        public Text nameLabel;
        public Text levelLabel;
        public Text summaryLabel;
        public Text upgradeButtonLabel;

        [Header("Unit / Ship Roster")]
        public GameObject rosterSection;
        public Text rosterTitleLabel;
        public Transform rosterListParent;
        public GameObject rosterRowPrefab;

        private Building _building;

        public void Bind(Building building)
        {
            _building = building;
            Render();
        }

        private void Render()
        {
            if (nameLabel != null) nameLabel.text = BuildingInfo.DisplayName(_building.Type).ToUpper();
            if (levelLabel != null) levelLabel.text = $"Level {_building.Level}";
            if (summaryLabel != null) summaryLabel.text = BuildingInfo.Summary(_building.Type);
            if (upgradeButtonLabel != null) upgradeButtonLabel.text = $"Upgrade — {_building.UpgradeCost} Materials";

            bool showBarracksRoster = _building.Type == BuildingType.Barracks;
            bool showSpaceportRoster = _building.Type == BuildingType.Spaceport;
            rosterSection.SetActive(showBarracksRoster || showSpaceportRoster);

            foreach (Transform child in rosterListParent) Destroy(child.gameObject);

            if (showBarracksRoster)
            {
                rosterTitleLabel.text = "TRAINABLE UNITS";
                foreach (TroopType troop in System.Enum.GetValues(typeof(TroopType)))
                    AddRosterRow(TroopInfo.DisplayName(troop), TroopInfo.Role(troop));
            }
            else if (showSpaceportRoster)
            {
                rosterTitleLabel.text = "BUILDABLE SHIPS";
                foreach (ShipType ship in System.Enum.GetValues(typeof(ShipType)))
                    AddRosterRow(ship.ToString(), ShipInfo.Role(ship));
            }
        }

        private void AddRosterRow(string title, string role)
        {
            var row = Instantiate(rosterRowPrefab, rosterListParent);
            row.GetComponent<RosterRowView>()?.Bind(title, role);
        }

        public void OnUpgrade()
        {
            // Hook up to your economy system: deduct UpgradeCost, start an upgrade timer,
            // then increment _building.Level and re-render on completion.
        }
    }

    /// Bound to the roster row prefab; fills in a unit/ship name and its role description.
    public class RosterRowView : MonoBehaviour
    {
        public Text nameLabel;
        public Text roleLabel;

        public void Bind(string name, string role)
        {
            if (nameLabel != null) nameLabel.text = name;
            if (roleLabel != null) roleLabel.text = role;
        }
    }
}
