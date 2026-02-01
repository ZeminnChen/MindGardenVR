using UnityEngine;
using System.Collections;

public class PlantingSpot : MonoBehaviour
{
    [Header("UI References")]
    public GameObject menuPopup;
    private Transform cameraTransform;

    [Header("Time Configuration")]
    public float plantDuration = 60.0f;
    public float menuMaxDuration = 1.5f;
    public float shrinkDuration = 1.5f;

    [Header("Status (Read Only)")]
    public bool isPlanted = false;

    private float menuTimer = 0f;

    void Start()
    {
        if (Camera.main != null)
            cameraTransform = Camera.main.transform;
    }

    public void OnGazeEnter()
    {
        if (!isPlanted && menuPopup != null)
        {
            menuPopup.SetActive(true);
            menuTimer = menuMaxDuration;
        }
    }

    public void OnGazeExit()
    {
        if (menuPopup != null)
        {
            menuPopup.SetActive(false);
        }
    }

    private void Update()
    {
        if (menuPopup != null && menuPopup.activeSelf)
        {
            // BILLBOARDING: Menu always faces the player
            menuPopup.transform.LookAt(cameraTransform);
            menuPopup.transform.Rotate(0, 180, 0);

            menuTimer -= Time.deltaTime;
            if (menuTimer <= 0)
            {
                menuPopup.SetActive(false);
            }
        }
    }

    public void SelectAndPlant(string seedName)
    {
        if (isPlanted) return;

        if (InventoryManager.Instance.HasSeed(seedName))
        {
            InventoryManager.Instance.ConsumeSeed(seedName);
            var seedData = InventoryManager.Instance.seeds.Find(s => s.name == seedName);

            if (seedData != null && seedData.flowerPrefab != null)
            {
                GameObject newPlant = Instantiate(seedData.flowerPrefab, transform.position, Quaternion.identity, transform);

                InventoryManager.Instance.plantasTotales++;
                InventoryManager.Instance.NotificarCambiosUI();
                
                StartCoroutine(GrowRoutine(newPlant));
                StartCoroutine(PlantLifeCycle(newPlant));

                isPlanted = true;
                if (menuPopup != null) menuPopup.SetActive(false);
            }
        }
    }

    private IEnumerator PlantLifeCycle(GameObject plant)
    {
        yield return new WaitForSeconds(plantDuration);

        float timer = 0f;
        if (plant != null)
        {
            Vector3 initialScale = plant.transform.localScale;
            while (timer < shrinkDuration)
            {
                if (plant == null) break;
                timer += Time.deltaTime;
                plant.transform.localScale = Vector3.Lerp(initialScale, Vector3.zero, timer / shrinkDuration); 
                yield return null;
            }
        }

        if (plant != null) Destroy(plant);
        isPlanted = false;
    }

    private IEnumerator GrowRoutine(GameObject flower)
    {
        if (flower == null) yield break;
        flower.transform.localScale = Vector3.zero;
        while (flower != null && flower.transform.localScale.x < 1f)
        {
            flower.transform.localScale += Vector3.one * (Time.deltaTime * 1.5f);
            yield return null;
        }
        if (flower != null) flower.transform.localScale = Vector3.one;
    }
}