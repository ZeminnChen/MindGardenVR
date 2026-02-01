using UnityEngine;
using UnityEngine.UI; 
using System.Collections;

public class LanternAction : MonoBehaviour
{
    [Header("Referencias")]
    public MeditationHandler handler; 

    [Header("Botones (Imágenes)")]
    public Button btnLotus; 
    public Button btnZen; 
    public Button btnBamboo;

    [Header("Configuración Luz")]
    public Light lantern; 
    public float duration = 2.0f;
    public float maxIntensity = 1.0f;

    [Header("Configuración Menú")]
    public GameObject menuMeditation; 
    public float autoCloseTime = 10.0f; 

    private CanvasGroup menuCanvasGroup;
    private float timer = 0f;
    private bool isMenuOpen = false;
    private bool isAnimating = false;

    void Start()
    {        
        if (menuMeditation != null) {
            menuCanvasGroup = menuMeditation.GetComponent<CanvasGroup>();
            if (menuCanvasGroup == null) menuCanvasGroup = menuMeditation.AddComponent<CanvasGroup>();
            
            // Aseguramos que empiece apagado y oculto
            menuMeditation.SetActive(false);
            menuCanvasGroup.alpha = 0f;
        }
        
        if (lantern != null) lantern.enabled = false;

        // Listener botones
        if (btnLotus != null) btnLotus.onClick.AddListener(() => StartSession(1));
        if (btnZen != null) btnZen.onClick.AddListener(() => StartSession(2));
        if (btnBamboo != null) btnBamboo.onClick.AddListener(() => StartSession(3));
        
        // --- CORRECCIÓN EXTRA ---
        // Forzamos el apagado de los botones al inicio por si acaso
        if (btnZen != null) btnZen.gameObject.SetActive(false);
        if (btnBamboo != null) btnBamboo.gameObject.SetActive(false);
    }

    void Update()
    {
        if (menuMeditation != null && menuMeditation.activeSelf)
        {
            Vector3 targetPos = new Vector3(Camera.main.transform.position.x, menuMeditation.transform.position.y, Camera.main.transform.position.z);
            menuMeditation.transform.LookAt(targetPos);
            menuMeditation.transform.Rotate(0, 180, 0);
        }

        if (isMenuOpen && !isAnimating)
        {
            timer -= Time.deltaTime;
            if (timer <= 0) CerrarMenu();
        }
    }

    public void OnGazeClick()
    {
        if (!isMenuOpen && !isAnimating)
        {
            StartCoroutine(SwitchOnAndShowMenu());
        }
    }

    IEnumerator SwitchOnAndShowMenu()
    {
        isAnimating = true;

        // --- DEBUG (EL CHIVATO) ---
        int plantas = InventoryManager.Instance.plantasTotales;
        Debug.Log("🔍 DIAGNÓSTICO: La linterna detecta " + plantas + " plantas.");

        if (btnZen != null)
        {
            bool debeVerse = (plantas >= 3);
            btnZen.gameObject.SetActive(debeVerse);
            Debug.Log("🔍 DIAGNÓSTICO: Botón Zen debe verse: " + debeVerse);
        }
        else Debug.LogError("❌ ERROR: La casilla 'Btn Zen' está vacía en el Inspector.");

        if (btnBamboo != null)
        {
            bool debeVerse = (plantas >= 5);
            btnBamboo.gameObject.SetActive(debeVerse);
            Debug.Log("🔍 DIAGNÓSTICO: Botón Bamboo debe verse: " + debeVerse);
        }
        // -------------------------

        // Lotus siempre visible
        if (btnLotus != null) btnLotus.gameObject.SetActive(true);

        float time = 0f;
        if (lantern != null) lantern.enabled = true;
        if (menuMeditation != null) menuMeditation.SetActive(true);

        while (time < duration)
        {
            time += Time.deltaTime;
            float progress = time / duration;
            if (lantern != null) lantern.intensity = Mathf.Lerp(0f, maxIntensity, progress);
            if (menuCanvasGroup != null) menuCanvasGroup.alpha = Mathf.Lerp(0f, 1f, progress);
            yield return null;
        }

        if (lantern != null) lantern.intensity = maxIntensity;
        if (menuCanvasGroup != null) menuCanvasGroup.alpha = 1f;

        isMenuOpen = true;
        isAnimating = false;
        timer = autoCloseTime;
    }

    public void CerrarMenu()
    {
        if (!isMenuOpen) return;
        StartCoroutine(SwitchOffRoutine());
    }

    IEnumerator SwitchOffRoutine()
    {
        isAnimating = true;
        isMenuOpen = false; 

        float time = 0f;
        float startAlpha = menuCanvasGroup.alpha;
        float startIntensity = (lantern != null) ? lantern.intensity : 0;

        while (time < duration)
        {
            time += Time.deltaTime;
            float progress = time / duration;
            if (lantern != null) lantern.intensity = Mathf.Lerp(startIntensity, 0f, progress);
            if (menuCanvasGroup != null) menuCanvasGroup.alpha = Mathf.Lerp(startAlpha, 0f, progress);
            yield return null;
        }

        if (lantern != null) lantern.enabled = false;
        if (menuMeditation != null) menuMeditation.SetActive(false);
        
        isAnimating = false;
    }

    void StartSession(int type)
    {
        CerrarMenu();
        if (handler != null)
        {
            switch (type)
            {
                case 1: handler.PlayLotus(); break;
                case 2: handler.PlayZen(); break;
                case 3: handler.PlayBamboo(); break;
            }
        }
    }
}