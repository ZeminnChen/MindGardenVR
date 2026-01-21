using UnityEngine;

public class WateringCan : MonoBehaviour
{
    public void PickUp()
    {
        PlayerInventory inventory = FindObjectOfType<PlayerInventory>();

        if (inventory != null)
        {
            inventory.hasWateringCan = true; 
            Debug.Log("Watering can.");

            gameObject.SetActive(false);
        }
    }
}