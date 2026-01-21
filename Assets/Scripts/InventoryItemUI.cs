using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class InventoryItemUI : MonoBehaviour
{
    public string seedName;
    public TextMeshProUGUI quantityText;
    public GameObject flower3DPrefab; // Drag the 3D FLOWER MODEL here
    private int quantity = 1;

    void Start()
    {
        // Automatically link the UI button to the SelectSeed function
        Button btn = GetComponent<Button>();
        if (btn != null) btn.onClick.AddListener(SelectSeed);
        UpdateText();
    }

    public void AddOne()
    {
        quantity++;
        UpdateText();
    }

    public void RemoveOne()
    {
        quantity--;
        if (quantity <= 0)
        {
            Destroy(gameObject); // Si no hay más, desaparece del inventario
        }
        else
        {
            UpdateText();
        }
    }

    public void SelectSeed()
    {
        PlayerInventory player = Object.FindFirstObjectByType<PlayerInventory>();
        if (player != null)
        {
            player.selectedSeedName = this.seedName;
            player.prefabToPlant = this.flower3DPrefab; // Passes the 3D model to the player
        }
    }

    private void UpdateText()
    {
        if (quantityText != null)
        {
            quantityText.gameObject.SetActive(quantity > 1);
            quantityText.text = "x" + quantity;
        }
    }
}