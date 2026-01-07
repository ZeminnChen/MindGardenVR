using UnityEngine;

public class PurchaseHandler : MonoBehaviour
{
    public string seedName;
    public GameObject flowerPrefab;
    public Transform inventoryParent;

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

        GameObject newItem = Instantiate(flowerPrefab, inventoryParent);
        InventoryItemUI itemUI = newItem.GetComponent<InventoryItemUI>();
        itemUI.seedName = seedName;
    }
}
