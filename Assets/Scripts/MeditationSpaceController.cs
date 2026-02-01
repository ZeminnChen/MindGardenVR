using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using UnityEngine.InputSystem; // Asegúrate de tener esto para el New Input System

public class MeditationSpaceController : MonoBehaviour
{
    public Camera mainCamera;
    public ParticleSystem starEffect; 
    public Image fadePanel;
    public float fadeDuration = 1.5f;
    public AudioSource audioSource; 
    public GameObject inventoryPanel; 
    public GameObject subtitleText; 

    private int originalMask;
    private Color originalBackColor;

    void Start()
    {
        if (mainCamera != null)
        {
            // Guardamos la configuración inicial pero ocultamos las estrellas
            originalMask = mainCamera.cullingMask & ~(1 << LayerMask.NameToLayer("Stars"));
            mainCamera.cullingMask = originalMask;
            originalBackColor = mainCamera.backgroundColor;
        }
        
        if (starEffect != null) 
        {
            starEffect.Stop();
            starEffect.gameObject.SetActive(false);
        }
        
        if (subtitleText != null) subtitleText.SetActive(false);

        // Inicializar el panel de fade invisible
        Color c = fadePanel.color;
        c.a = 0;
        fadePanel.color = c;
    }

    public void Activate()
    {
        if (audioSource != null) audioSource.Stop(); 
        StopAllCoroutines(); 
        StartCoroutine(MeditationRoutine());
    }

    IEnumerator MeditationRoutine()
    {
        yield return StartCoroutine(Fade(1));
        
        if (inventoryPanel != null) inventoryPanel.SetActive(false);
        
        ApplySpaceVisuals(true);
        if (subtitleText != null) subtitleText.SetActive(true);

        yield return StartCoroutine(Fade(0));

        if (audioSource != null && audioSource.clip != null) 
        {
            audioSource.Play();

            while (audioSource.isPlaying)
            {
                if (Keyboard.current != null && Keyboard.current.wKey.wasPressedThisFrame) 
                {
                    audioSource.Stop();
                    break; 
                }
                yield return null;
            }
        }

        if (subtitleText != null) subtitleText.SetActive(false);

        yield return StartCoroutine(Fade(1));
        ApplySpaceVisuals(false);
        yield return StartCoroutine(Fade(0));
    }

    void ApplySpaceVisuals(bool isSpace)
    {
        if (isSpace)
        {
            mainCamera.cullingMask = LayerMask.GetMask("Stars", "UI");
            mainCamera.clearFlags = CameraClearFlags.SolidColor;
            mainCamera.backgroundColor = Color.black;
            
            if (starEffect != null) 
            {
                starEffect.gameObject.SetActive(true);
                starEffect.Play();
            }
        }
        else
        {
            mainCamera.cullingMask = originalMask;
            mainCamera.clearFlags = CameraClearFlags.Skybox;
            mainCamera.backgroundColor = originalBackColor;
            
            if (starEffect != null) 
            {
                starEffect.Stop();
                starEffect.gameObject.SetActive(false);
            }
        }
    }

    IEnumerator Fade(float targetAlpha)
    {
        float elapsed = 0;
        Color c = fadePanel.color;
        float startAlpha = c.a;
        while (elapsed < fadeDuration)
        {
            elapsed += Time.deltaTime;
            c.a = Mathf.Lerp(startAlpha, targetAlpha, elapsed / fadeDuration);
            fadePanel.color = c;
            yield return null;
        }
    }
}