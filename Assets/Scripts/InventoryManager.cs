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
        // 1. Buscamos la semilla en la lista lógica
        var seed = seeds.Find(s => s.name == seedName);
        
        if (seed != null && seed.quantity > 0)
        {
            seed.quantity--; // Restamos stock lógico
            Debug.Log($"Stock lógico de {seedName} ahora es: {seed.quantity}");

            // 2. Buscamos el elemento visual en la UI para actualizarlo
            // Usamos FindObjectsByType para encontrar todos los botones del inventario
            InventoryItemUI[] uiItems = Object.FindObjectsByType<InventoryItemUI>(FindObjectsSortMode.None);
            
            foreach (var uiItem in uiItems)
            {
                // IMPORTANTE: Comparamos el nombre que viene del botón con el del item UI
                if (uiItem.seedName == seedName)
                {
                    uiItem.RemoveOne(); // Esto actualiza el texto o destruye el objeto
                    return; // Salimos del bucle una vez encontrado
                }
            }
            
            Debug.LogWarning($"No se encontró el objeto UI para: {seedName}. Revisa que el 'seedName' en el Inspector coincida.");
        }
    }
}