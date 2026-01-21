using UnityEngine;

public class Pot : MonoBehaviour
{
    public Transform spawnPoint; 
    private bool isOccupied = false;

    public void Plant()
    {
        PlayerInventory player = Object.FindFirstObjectByType<PlayerInventory>();

        if (player != null && !isOccupied && player.prefabToPlant != null)
        {
            Instantiate(player.prefabToPlant, spawnPoint.position, spawnPoint.rotation);
            isOccupied = true;
            player.ClearSelection(); 
        }
    }
}