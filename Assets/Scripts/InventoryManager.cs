using UnityEngine;
using System.Collections.Generic;

public class InventoryManager : MonoBehaviour
{
    public static InventoryManager Instance;

    [System.Serializable]
    public class SeedData
    {
        public string name;
        public int quantity;
        public GameObject flowerPrefab;
    }

    public List<SeedData> seeds;

    void Awake() { Instance = this; }

    public void AddSeedData(string seedName)
    {
        var seed = seeds.Find(s => s.name == seedName);
        if (seed != null) seed.quantity++;
    }

    public bool HasSeed(string seedName) => seeds.Find(s => s.name == seedName).quantity > 0;

    // Añade esto dentro de tu clase InventoryManager
    public void ConsumeSeed(string seedName)
    {
        var seed = seeds.Find(s => s.name == seedName);
        if (seed != null && seed.quantity > 0)
        {
            seed.quantity--;

            // Buscamos el objeto visual en el inventario para que el texto disminuya allí también
            InventoryItemUI[] uiItems = Object.FindObjectsByType<InventoryItemUI>(FindObjectsSortMode.None);
            foreach (var uiItem in uiItems)
            {
                if (uiItem.seedName == seedName)
                {
                    // Aquí necesitarás un método público en InventoryItemUI para restar
                    uiItem.RemoveOne();
                    break;
                }
            }
        }
    }
}