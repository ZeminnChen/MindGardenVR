using UnityEngine;
using System.Collections;

public class LanternAction : MonoBehaviour
{
    [Header("Light config")]
    public Light lantern; 
    public float duration = 2.0f;
    public float maxIntensity = 1.0f;
    private bool activated = false;

    [Header("Menu config")]
    public GameObject menuMeditation; 
    private CanvasGroup menuCanvasGroup;


    void Start()
    {        
        if (menuMeditation != null) {
            menuCanvasGroup = menuMeditation.GetComponent<CanvasGroup>();
            if (menuCanvasGroup == null) {
                menuCanvasGroup = menuMeditation.AddComponent<CanvasGroup>();
            }

            menuMeditation.SetActive(false);
            menuCanvasGroup.alpha = 0f;
        }
        
        if (lantern != null) lantern.enabled = false;
    }

    void Update()
    {
        if (menuMeditation != null && menuMeditation.activeSelf)
        {
            Vector3 targetPos = new Vector3(Camera.main.transform.position.x, menuMeditation.transform.position.y, Camera.main.transform.position.z);
            menuMeditation.transform.LookAt(targetPos);
            menuMeditation.transform.Rotate(0, 180, 0);
        }
    }

    public void OnGazeClick()
    {
        if (!activated)
        {
            StartCoroutine(SwitchOnAndShowMenu());
            activated = true;
        }
    }

    IEnumerator SwitchOnAndShowMenu()
    {
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
    }

}