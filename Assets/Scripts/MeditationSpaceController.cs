using UnityEngine;
using UnityEngine.UI;
using System.Collections;


// Stars space
public class MeditationSpaceController : MonoBehaviour
{
    public Camera mainCamera;
    public GameObject starEffect;
    public Image fadePanel;
    public float fadeDuration = 1.5f;
    public AudioSource audioSource; 

    private int originalMask;
    private Color originalBackColor;

    void Start()
    {
        if (mainCamera != null)
        {
            originalMask = mainCamera.cullingMask;
            originalBackColor = mainCamera.backgroundColor;
        }
        starEffect.SetActive(false);
        
        Color c = fadePanel.color;
        c.a = 0;
        fadePanel.color = c;
    }

    public void Activate()
    {
        StopAllCoroutines(); 
        StartCoroutine(MeditationRoutine());
    }

    IEnumerator MeditationRoutine()
    {
        yield return StartCoroutine(Fade(1));
        ApplySpaceVisuals(true);
        yield return StartCoroutine(Fade(0));

        if (audioSource != null)
        {
            while (audioSource.isPlaying)
            {
                yield return null;
            }
        }

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
            starEffect.SetActive(true);
        }
        else
        {
            mainCamera.cullingMask = originalMask;
            mainCamera.clearFlags = CameraClearFlags.Skybox;
            mainCamera.backgroundColor = originalBackColor;
            starEffect.SetActive(false);
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