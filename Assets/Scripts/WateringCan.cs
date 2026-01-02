using UnityEngine;

public class WateringCan : MonoBehaviour
{
    // Funci�n que llamar� el Event Trigger tras mirar 2 segundos
    public void PickUp()
    {
        // Buscamos el inventario en el jugador (que suele estar en la c�mara)
        PlayerInventory inventory = FindObjectOfType<PlayerInventory>();

        if (inventory != null)
        {
            inventory.tieneRegadera = true; // Marcamos que la tiene 
            Debug.Log("Regadera recogida");

            // Ocultamos la regadera de la mesa
            gameObject.SetActive(false);
        }
    }
}