using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class InventoryItemUI : MonoBehaviour
{
    public string seedName;
    public TextMeshProUGUI quantityText;
    public GameObject flower3DPrefab; 

    void Start()
    {
        Button btn = GetComponent<Button>();
        if (btn != null) btn.onClick.AddListener(SelectSeed);
        
        // Al nacer, nos actualizamos
        RefreshVisuals();
    }

    public void RefreshVisuals()
    {
        if (InventoryManager.Instance != null)
        {
            var seedData = InventoryManager.Instance.seeds.Find(s => s.name == seedName);
            
            if (seedData != null)
            {
                int currentQty = seedData.quantity;

                // CAMBIO IMPORTANTE:
                // Si hay 0, NO destruimos el objeto. Solo lo desactivamos (ocultamos).
                // Si hay > 0, lo activamos (mostramos).
                if (currentQty > 0)
                {
                    gameObject.SetActive(true);
                    
                    if (quantityText != null)
                    {
                        quantityText.gameObject.SetActive(true);
                        quantityText.text = "x" + currentQty;
                    }
                }
                else
                {
                    // Lo ocultamos para que no moleste, pero sigue existiendo en memoria
                    gameObject.SetActive(false);
                }
            }
        }
    }

    // Estas funciones solo llaman a refrescar visualmente
    public void AddOne() => RefreshVisuals();
    public void RemoveOne() => RefreshVisuals();

    public void SelectSeed()
    {
        PlayerInventory player = Object.FindFirstObjectByType<PlayerInventory>();
        if (player != null)
        {
            player.selectedSeedName = this.seedName;
            player.prefabToPlant = this.flower3DPrefab; 
            Debug.Log("Seleccionada semilla: " + seedName);
        }
    }
}