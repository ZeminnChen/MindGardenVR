using UnityEngine;
using TMPro; // Necesario para TextMeshPro

public class PlantCounterUI : MonoBehaviour
{
    public TextMeshProUGUI textoContador;

    void Start()
    {
        // Al empezar, ponemos el número que haya guardado
        ActualizarTexto();
    }

    public void ActualizarTexto()
    {
        if (InventoryManager.Instance != null && textoContador != null)
        {
            // Escribe: "Plantas: 5"
            textoContador.text = "Plants: " + InventoryManager.Instance.plantasTotales;
        }
    }
}