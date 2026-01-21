using UnityEngine;
using System.Collections.Generic;
using System.Collections;

public class PlantingSpot : MonoBehaviour
{
    public GameObject menuPopup;
    public float growSpeed = 0.25f; // <--- NUEVO: 0.25 significa que tarda 4 segundos en crecer
    private bool isPlanted = false;

    public void OnGazeEnter()
    {
        // Si el canvas estaba desactivado por el tick, esto lo activará al mirar
        if (!isPlanted && menuPopup != null)
        {
            menuPopup.SetActive(true);
        }
    }

    public void OnGazeExit()
    {
        if (menuPopup != null)
        {
            menuPopup.SetActive(false);
        }
    }

    public void SeleccionarYPlantar(string nombreSemilla)
    {
        if (isPlanted) return;

        if (InventoryManager.Instance.HasSeed(nombreSemilla))
        {
            InventoryManager.Instance.ConsumeSeed(nombreSemilla);

            GameObject prefab = InventoryManager.Instance.seeds.Find(s => s.name == nombreSemilla).flowerPrefab;

            // Instanciamos y crecemos
            GameObject newFlower = Instantiate(prefab, transform.position, Quaternion.identity, transform);
            StartCoroutine(GrowRoutine(newFlower));

            isPlanted = true;
            menuPopup.SetActive(false);
        }
        else
        {
            Debug.Log("No tienes stock de: " + nombreSemilla);
        }
    }

    IEnumerator GrowRoutine(GameObject flower)
    {
        flower.transform.localScale = Vector3.zero;
        while (flower.transform.localScale.x < 1f)
        {
            // Multiplicamos por growSpeed para controlar la lentitud
            flower.transform.localScale += Vector3.one * (Time.deltaTime * growSpeed);
            yield return null;
        }
        flower.transform.localScale = Vector3.one; // Aseguramos que quede a tamaño real
    }
}