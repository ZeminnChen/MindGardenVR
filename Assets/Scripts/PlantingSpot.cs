using UnityEngine;
using System.Collections;

public class PlantingSpot : MonoBehaviour
{
    [Header("Referencias UI")]
    public GameObject menuPopup; // ¡Arrastra el Canvas aquí!

    [Header("Configuración de Tiempo")]
    public float duracionPlanta = 8.0f; // La flor vive 8 segundos
    public float duracionMenu = 10.0f;  // El menú se cierra solo a los 10s

    [Header("Estado (Solo lectura)")]
    public bool isPlanted = false;
    
    private float menuTimer = 0f;

    // --- 1. CONTROL DEL MENÚ (GAZE) ---
    public void OnGazeEnter()
    {
        // Solo abrimos si está vacía
        if (!isPlanted && menuPopup != null)
        {
            menuPopup.SetActive(true);
            menuTimer = duracionMenu; // Reiniciamos la cuenta atrás del menú
        }
    }

    public void OnGazeExit()
    {
        // OPCIONAL: Si quieres que se cierre AL INSTANTE cuando miras a otro lado,
        // descomenta la línea de abajo.
        // Si prefieres que se quede flotando unos segundos, déjalo así.
        
        if (menuPopup != null) menuPopup.SetActive(false); 
    }

    // --- 2. BUCLE DEL MENÚ ---
    private void Update()
    {
        // Si el menú está abierto, contamos hacia atrás
        if (menuPopup != null && menuPopup.activeSelf)
        {
            menuTimer -= Time.deltaTime;

            // ¡Se acabó el tiempo! Cerramos el menú.
            if (menuTimer <= 0)
            {
                menuPopup.SetActive(false);
            }
        }
    }

    // --- 3. LÓGICA DE PLANTAR ---
    public void SeleccionarYPlantar(string nombreSemilla)
    {
        if (isPlanted) return;

        if (InventoryManager.Instance.HasSeed(nombreSemilla))
        {
            InventoryManager.Instance.ConsumeSeed(nombreSemilla);
            var seedData = InventoryManager.Instance.seeds.Find(s => s.name == nombreSemilla);

            if (seedData != null && seedData.flowerPrefab != null)
            {
                // 1. Crear Planta
                GameObject nuevaPlanta = Instantiate(seedData.flowerPrefab, transform.position, Quaternion.identity, transform);

                InventoryManager.Instance.plantasTotales++;
                InventoryManager.Instance.NotificarCambiosUI();
                
                // 2. Hacerla crecer
                StartCoroutine(GrowRoutine(nuevaPlanta));

                // 3. Programar su muerte (La nueva lógica de 8 segundos)
                StartCoroutine(CicloDeVidaPlanta(nuevaPlanta));

                // 4. Actualizar Estado
                isPlanted = true;
                
                // 5. Cerrar menú inmediatamente
                if (menuPopup != null) menuPopup.SetActive(false);
            }
        }
    }

    // --- 4. RUTINAS DE TIEMPO ---
    
    // Esta rutina espera X segundos y luego mata la planta
    IEnumerator CicloDeVidaPlanta(GameObject planta)
    {
        // Esperamos los 8 segundos de vida
        yield return new WaitForSeconds(duracionPlanta);

        // Efecto opcional: encoger antes de desaparecer
        float timer = 0f;
        Vector3 escalaFinal = planta.transform.localScale;
        while (timer < 1.0f)
        {
            timer += Time.deltaTime;
            // Lerp hacia 0 (encoger)
            planta.transform.localScale = Vector3.Lerp(escalaFinal, Vector3.zero, timer); 
            yield return null;
        }

        // Adiós planta
        if (planta != null) Destroy(planta);
        
        // ¡La maceta está libre de nuevo!
        isPlanted = false;
        Debug.Log("La planta ha muerto de vieja. Maceta libre.");
    }

    IEnumerator GrowRoutine(GameObject flower)
    {
        flower.transform.localScale = Vector3.zero;
        while (flower != null && flower.transform.localScale.x < 1f)
        {
            flower.transform.localScale += Vector3.one * (Time.deltaTime * 1.5f);
            yield return null;
        }
        if (flower != null) flower.transform.localScale = Vector3.one;
    }
}