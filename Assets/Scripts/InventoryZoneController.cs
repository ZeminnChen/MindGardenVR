using UnityEngine;

public class InventoryZoneController : MonoBehaviour
{
    public GameObject inventoryCanvas;
    private static int zonesEntered = 0; 

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            zonesEntered++;
            UpdateCanvas();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            zonesEntered--;
            UpdateCanvas();
        }
    }

    private void UpdateCanvas()
    {
        if (inventoryCanvas != null)
        {
            inventoryCanvas.SetActive(zonesEntered > 0);
        }
    }
}