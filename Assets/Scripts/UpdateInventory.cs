using TMPro;
using UnityEngine;

public class InventoryItemUI : MonoBehaviour
{
    public string seedName; 
    public TextMeshProUGUI quantityText;

    private int quantity = 1;

    public void AddOne()
    {
        quantity++;
        UpdateText();
    }

    private void UpdateText()
    {
        quantityText.gameObject.SetActive(quantity > 1);
        quantityText.text = "x" + quantity;
    }
}
