using UnityEngine;

public class InventoryZoneController : MonoBehaviour
{
    public GameObject inventoryPanel;

    void Start()
    {
        inventoryPanel.SetActive(false);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("InventoryZone"))
        {
            inventoryPanel.SetActive(true);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("InventoryZone"))
        {
            inventoryPanel.SetActive(false);
        }
    }
}