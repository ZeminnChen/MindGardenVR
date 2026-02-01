using UnityEngine;

public class PurchaseHandler : MonoBehaviour
{
    public string seedName;
    public GameObject flowerUIPrefab; 
    public Transform inventoryParent; 
    public GameObject emptyMessage; 

    public void ExecutePurchase() 
    {
        // 1. Añadimos la semilla a la base de datos
        InventoryManager.Instance.AddSeedData(seedName);

        // 2. VERIFICACIÓN DE SEGURIDAD PARA LA TIENDA VISUAL
        // Buscamos si ya existe el icono visual en el panel de inventario PRINCIPAL (la mochila)
        bool visualItemExists = false;
        
        // Buscamos solo en los hijos del panel de inventario (no en las macetas)
        InventoryItemUI[] itemsEnMochila = inventoryParent.GetComponentsInChildren<InventoryItemUI>(true); // true = busca ocultos

        foreach (InventoryItemUI item in itemsEnMochila)
        {
            if (item.seedName == seedName)
            {
                visualItemExists = true;
                break;
            }
        }

        // Si es la primera vez que compramos esta flor y no tiene dibujo, lo creamos
        if (!visualItemExists)
        {
            GameObject newItem = Instantiate(flowerUIPrefab, inventoryParent);
            InventoryItemUI uiScript = newItem.GetComponent<InventoryItemUI>();
            uiScript.seedName = seedName;
        }

        // 3. ACTUALIZAMOS TODO
        // Esto hará que las cartas en las macetas aparezcan mágicamente si estaban ocultas
        InventoryManager.Instance.NotificarCambiosUI();
        
        UpdateEmptyMessage();
    }

    public void UpdateEmptyMessage()
    {
        if (emptyMessage != null)
            emptyMessage.SetActive(inventoryParent.childCount == 0);
    }
}