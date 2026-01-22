using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class InventoryItemUI : MonoBehaviour
{
    public string seedName;
    public TextMeshProUGUI quantityText;
    public GameObject flower3DPrefab; // Drag the 3D FLOWER MODEL here
    private int quantity = 0;

    void Start()
    {
        Button btn = GetComponent<Button>();
        if (btn != null) btn.onClick.AddListener(SelectSeed);
        //UpdateText();
        SyncQuantityWithManager();
    }

    private void SyncQuantityWithManager()
    {
        if (InventoryManager.Instance != null)
        {
            var seedData = InventoryManager.Instance.seeds.Find(s => s.name == seedName);
            if (seedData != null)
            {
                quantity = seedData.quantity;
            }
        }
        UpdateText();
    }

    public void AddOne()
    {
        quantity++;
        UpdateText();
    }

    /*
    public void RemoveOne()
    {
        quantity--;
        if (quantity <= 0)
        {
            Destroy(gameObject); 
        }
        else
        {
            UpdateText();
        }
    }
    */
        public void RemoveOne()
    {
        // Obtenemos la cantidad actualizada del Manager directamente
        if (InventoryManager.Instance != null)
        {
            var seedData = InventoryManager.Instance.seeds.Find(s => s.name == seedName);
            if (seedData != null)
            {
                quantity = seedData.quantity; // Ahora quantity es la del Manager
            }
            else
            {
                quantity = 0;
            }
        }

        if (quantity <= 0)
        {
            Destroy(gameObject); // Se elimina el botón si no hay stock real
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
            player.prefabToPlant = this.flower3DPrefab; 
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