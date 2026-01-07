using UnityEngine;

public class PurchaseHandler : MonoBehaviour
{
    public string seedName;
    public GameObject flowerPrefab;
    public Transform inventoryParent;
    public GameObject emptyMessage; 

    void Start()
    {
        UpdateEmptyMessage();
    }

    public void ExecutePurchase()
    {
        InventoryItemUI[] items = inventoryParent.GetComponentsInChildren<InventoryItemUI>();

        foreach (InventoryItemUI item in items)
        {
            if (item.seedName == seedName)
            {
                item.AddOne();
                UpdateEmptyMessage(); 
                return;
            }
        }

        GameObject newItem = Instantiate(flowerPrefab, inventoryParent);
        InventoryItemUI itemUI = newItem.GetComponent<InventoryItemUI>();
        itemUI.seedName = seedName;

        UpdateEmptyMessage();
    }

    private void UpdateEmptyMessage()
    {
        if (emptyMessage != null)
        {
            bool hasItems = inventoryParent.childCount > 0;
            emptyMessage.SetActive(!hasItems);
        }
    }
}