using UnityEngine;
using System.Collections;

public class AudioZoneFader : MonoBehaviour
{
    [Header("Audio Settings")]
    public AudioSource targetAudioSource; 
    public float fadeSpeed = 0.5f;       
    public float maxVolume = 1.0f;      

    private Coroutine fadeCoroutine;

    private void OnTriggerEnter(Collider other)
    {

        if (other.CompareTag("Player"))
        {
            if (fadeCoroutine != null) StopCoroutine(fadeCoroutine);
            fadeCoroutine = StartCoroutine(FadeAudio(maxVolume));
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (fadeCoroutine != null) StopCoroutine(fadeCoroutine);
            fadeCoroutine = StartCoroutine(FadeAudio(0f));
        }
    }

    IEnumerator FadeAudio(float targetVolume)
    {
        while (!Mathf.Approximately(targetAudioSource.volume, targetVolume))
        {
            targetAudioSource.volume = Mathf.MoveTowards(targetAudioSource.volume, targetVolume, fadeSpeed * Time.deltaTime);
            yield return null;
        }
    }
}