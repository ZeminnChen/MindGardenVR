using UnityEngine;

public class PlayerInventory : MonoBehaviour
{
    [Header("Current Status")]
    public bool hasWateringCan = false; 
    public string selectedSeedName = ""; 

    [Header("Planting Reference")]
    public GameObject prefabToPlant; 

    public void ClearSelection()
    {
        selectedSeedName = "";
        prefabToPlant = null;
    }
}