using UnityEngine;
using TMPro;
using System.Collections;

public class MeditationHandler : MonoBehaviour
{
    [Header("Audio Tracks")]
    public AudioSource audioSource;
    public AudioClip lotusClip;
    public AudioClip zenClip;
    public AudioClip bambooClip;

    [Header("Visual Effects")]
    public Material starsSkybox;
    public TextMeshProUGUI subtitleText;
    [Range(0.1f, 2f)] public float transitionSpeed = 0.5f;

    private Coroutine sessionCoroutine;

    // --- BUTTONS ---

    public void PlayLotus() {
        string[] script = { "Welcome to the Lotus path.", "Breathe in the light...", "Let the world fade away." };
        float[] timing = { 1f, 5f, 10f };
        StartMeditation(lotusClip, script, timing);
    }

    public void PlayZen() {
        string[] script = { "Entering Zen mode.", "Find your center.", "The universe is within you." };
        float[] timing = { 1f, 4f, 8f };
        StartMeditation(zenClip, script, timing);
    }


    public void PlayBamboo() {
        string[] phrases = { 
            "This is a one minute guided meditation...", // 0:00
            "No matter what's going on in your life right now,", // 0:02
            "no matter how many thoughts are racing around your mind,", // 0:05
            "no matter how the body is feeling...", // 0:11
            "just take a moment to sit down and take a big deep breath.", // 0:14
            "Breathing in through the nose...", // 0:18
            "and out through the mouth.", // 0:21
            "Feel a sense of taking in fresh air. The lungs expand.", // 0:23
            "Feel a sense of letting go of any stress.", // 0:31
            "Feeling the muscles soften and relax...", // 0:36
            "Close your eyes if you'd like to.", // 0:41
            "Once more, breathing deeply in through the nose...", // 0:43
            "and out through the mouth.", // 0:48
            "Take a moment to pause. Allow the thoughts to come and go.", // 0:52
            "And then, gently opening the eyes again." // 0:57
        };

        float[] timestamps = {f, 2f, 5f, 11f, 14f, 18f, 21f, 23f, 31f, 36f, 41f, 43f, 48f, 52f, 57f };

        StartMeditation(bambooClip, phrases, timestamps); 
}

    // --- CORE LOGIC ---

    private void StartMeditation(AudioClip clip, string[] phrases, float[] times)
    {
        if (sessionCoroutine != null) StopCoroutine(sessionCoroutine);
        sessionCoroutine = StartCoroutine(MeditationRoutine(clip, phrases, times));
    }

    IEnumerator MeditationRoutine(AudioClip clip, string[] phrases, float[] times)
    {
        // 1. Fade to Black (Series Style Transition)
        yield return StartCoroutine(FadeExposure(1f, 0f));

        // 2. Change Skybox while dark
        RenderSettings.skybox = starsSkybox;
        subtitleText.text = ""; 

        // 3. Start Audio
        audioSource.clip = clip;
        audioSource.Play();

        // 4. Fade back up to the Stars
        StartCoroutine(FadeExposure(0f, 1f));

        // 5. Display Subtitles in real-time
        float startTime = Time.time;
        for (int i = 0; i < phrases.Length; i++)
        {
            while (Time.time - startTime < times[i]) yield return null;
            subtitleText.text = phrases[i];
        }

        // Clear subtitles after a while
        yield return new WaitForSeconds(4f);
        subtitleText.text = "";
    }

    IEnumerator FadeExposure(float start, float end)
    {
        float current = start;
        while (!Mathf.Approximately(current, end))
        {
            current = Mathf.MoveTowards(current, end, Time.deltaTime * transitionSpeed);
            RenderSettings.skybox.SetFloat("_Exposure", current);
            DynamicGI.UpdateEnvironment(); // Updates lighting for the garden
            yield return null;
        }
    }

    public void StopMeditation()
    {
        StopAllCoroutines();
        audioSource.Stop();
        subtitleText.text = "";
        RenderSettings.skybox.SetFloat("_Exposure", 1f);
    }
}