using UnityEngine;
using System.Collections;
using System.Collections.Generic; // Necesario para usar Listas

public class PlantingSpot : MonoBehaviour
{
    [Header("Lista de Plantas")]
    public List<GameObject> flowerModels; // Ahora puedes arrastrar varias flores aquí
    public float growthTime = 3.0f;
    private bool isPlanted = false;

    public void PlantFlower()
    {
        if (!isPlanted)
        {
            isPlanted = true;
            // Iniciamos el crecimiento para cada flor en la lista
            foreach (GameObject flower in flowerModels)
            {
                StartCoroutine(GrowRoutine(flower));
            }
        }
    }

    IEnumerator GrowRoutine(GameObject flower)
    {
        flower.SetActive(true);
        flower.transform.localScale = Vector3.zero;

        float timer = 0;
        while (timer < growthTime)
        {
            flower.transform.localScale = Vector3.Lerp(Vector3.zero, Vector3.one, timer / growthTime);
            timer += Time.deltaTime;
            yield return null;
        }
        flower.transform.localScale = Vector3.one;
    }
}