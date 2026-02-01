using UnityEngine;
using System.Collections.Generic;

public class InventoryManager : MonoBehaviour
{
    public static InventoryManager Instance;

    public int plantasTotales = 0;

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
        if (seed != null) 
        {
            seed.quantity++;
            NotificarCambiosUI(); // Avisamos a todos
        }
    }

    public bool HasSeed(string seedName) 
    {
        var seed = seeds.Find(s => s.name == seedName);
        return seed != null && seed.quantity > 0;
    }

    public void ConsumeSeed(string seedName)
    {
        var seed = seeds.Find(s => s.name == seedName);
        
        if (seed != null && seed.quantity > 0)
        {
            seed.quantity--; // Restamos
            NotificarCambiosUI(); // Avisamos a todos
        }
    }

    // --- NUEVA FUNCIÓN MAESTRA ---
    // Esta función busca TODOS los botones del juego (visibles y ocultos) y los actualiza.
    public void NotificarCambiosUI()
    {
        // El truco es 'FindObjectsInactive.Include'. Así encontramos las cartas ocultas.
        InventoryItemUI[] uiItems = Object.FindObjectsByType<InventoryItemUI>(FindObjectsInactive.Include, FindObjectsSortMode.None);
        
        foreach (var uiItem in uiItems)
        {
            uiItem.RefreshVisuals();
        }

        PlantCounterUI contador = Object.FindFirstObjectByType<PlantCounterUI>();
        if (contador != null)
        {
            contador.ActualizarTexto();
        }
    }
}