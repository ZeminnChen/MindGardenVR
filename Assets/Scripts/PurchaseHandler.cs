using UnityEngine;

public class PurchaseHandler : MonoBehaviour
{
    public string seedName;
    public GameObject flowerUIPrefab; 
    public Transform inventoryParent; 
    public GameObject emptyMessage; 

    public void ExecutePurchase() 
    {
        InventoryItemUI[] items = inventoryParent.GetComponentsInChildren<InventoryItemUI>();

        foreach (InventoryItemUI item in items)
        {
            if (item.seedName == seedName)
            {
                item.AddOne(); 
                return;
            }
        }

        GameObject newItem = Instantiate(flowerUIPrefab, inventoryParent);
        newItem.GetComponent<InventoryItemUI>().seedName = seedName;
        UpdateEmptyMessage();
    }

    public void UpdateEmptyMessage()
    {
        if (emptyMessage != null)
            emptyMessage.SetActive(inventoryParent.childCount == 0);
    }
}