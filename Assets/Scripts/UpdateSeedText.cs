using UnityEngine;
using TMPro;

public class UpdateSeedText : MonoBehaviour
{
    public string seedName; // Escribe aquí "Yellow", "Red" o "Blue" en el Inspector
    private TextMeshProUGUI textElement;

    void Start()
    {
        textElement = GetComponent<TextMeshProUGUI>();
    }

    void Update()
    {
        if (InventoryManager.Instance != null && textElement != null)
        {
            // Buscamos el stock real en el Manager
            var seed = InventoryManager.Instance.seeds.Find(s => s.name == seedName);

            if (seed != null)
            {
                // Si tienes 0, pondrá "0", si tienes más, pondrá "x5"
                textElement.text = seed.quantity > 0 ? "x" + seed.quantity : "0";

                // OPCIONAL: Si quieres que el texto sea rojo cuando no hay stock
                textElement.color = seed.quantity > 0 ? Color.white : Color.red;
                GetComponentInParent<UnityEngine.UI.Button>().interactable = (seed.quantity > 0);
            }
        }
    }
}