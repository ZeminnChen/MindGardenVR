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

    [Header("UI")]
    public TextMeshProUGUI subtitleText;

    private Coroutine sessionCoroutine;
    [Header("Breathing Guide")]
    public BreathingGuide breathingSphere; 

    IEnumerator MeditationRoutine(string[] phrases, float[] times)
    {
        subtitleText.text = ""; 
        AudioListener.pause = true; 
        if(breathingSphere != null) breathingSphere.gameObject.SetActive(true);

        while (!audioSource.isPlaying) yield return null;

        for (int i = 0; i < phrases.Length; i++)
        {
            while (audioSource.time < times[i]) yield return null;
            
            string currentPhrase = phrases[i].ToLower();
            subtitleText.text = phrases[i];

            if (breathingSphere != null){
                if (currentPhrase.Contains("breath in") || currentPhrase.Contains("inhale") || currentPhrase.Contains("fill up")){
                    breathingSphere.Inhale(3.0f); 
                }else if (currentPhrase.Contains("exhale") || currentPhrase.Contains("breath out") || currentPhrase.Contains("let it go")){
                    breathingSphere.Exhale(4.0f); 
                }
            }

            subtitleText.canvasRenderer.SetAlpha(0f);
            subtitleText.CrossFadeAlpha(1f, 0.5f, false);
        }

        while (audioSource.isPlaying) yield return null;
        
        if(breathingSphere != null) breathingSphere.ResetGuide();
        AudioListener.pause = false; 
    }

    void Start()
    {
        // Esto permite que este audio específico suene aunque pausemos todos los demás
        if (audioSource != null)
        {
            audioSource.ignoreListenerPause = true;
        }
    }

    public void PlayLotus() {
        string[] phrases = { 
            "I want you to let yourself be here, ",
            "in this moment and time.", 
            "Let go of expectations,", 
            "of to-do lists,",
            "and be here.", 
            "Be present.", 
            "Take a big breath in,", 
            "and on your exhale, sigh it out.",
            "Another big breath in,", 
            "exhale, let it go.", 
            "One more inhale; fill up,", 
            "exhal; sight it out.", 
            "Let your mind,",
            "your breath,", 
            "and your awareness of your body start to link up as one", 
            "as you take this moment for you", 
            "Be present in this space." 
        };
        float[] timestamps = { 1f, 4f, 8f, 10f, 12f, 15f, 17f, 20f, 25f, 29f, 33f, 38f, 44f, 46f, 47f, 51f, 54f };
        StartMeditation(lotusClip, phrases, timestamps); 
    }

    public void PlayZen() {
        string[] phrases = { 
            "I want you to start by placing both hands on your heart.", 
            "Take a big breath in, ", 
            "feel your breath rise,", 
            "and a long breath out, exhale.", 
            "And start to feel your heart beat, ", 
            "the beauty of being you", 
            "and being alive in your own skin.", 
            "And the one thing that you have that nobody else has", 
            "is you. ",
            "Your voice, ",
            "your mind, ",
            "your story, ", 
            "your vision.",
            "So live as only you can.", 
            "The one that you are looking for is you.", 
            "Set your intention for the day.", 
            "Practice gratitude for how amazing you are.", 
            "Shine your light wherever you go.", 
            "You are beautiful and blessed." 
        };
        float[] timestamps = { 1f, 6f, 9f, 12f, 16f, 20f, 21f, 26f, 29f, 31f, 33f, 35f, 36f, 38f, 41f, 46f, 48f, 52f, 55f }; 
        StartMeditation(zenClip, phrases, timestamps); 
    }

    public void PlayBamboo() {
        string[] phrases = { 
            "This is a one minute guided meditation.", 
            "No matter what's going on in your life right now,", 
            "no matter how many thoughts are racing around your mind,", 
            "no matter how the body is feeling, ", 
            "just take a moment to sit down and take a big deep breath.", 
            "Breathing in through the nose, ", 
            "and out through the mouth.", 
            "as you breath in, feel a sense of taking in fresh air, ", 
            "the lungs expanding, ",
            "As you breath out, feel a sense of letting go of any stress in the body,", 
            "in the mind, ",
            "just feeling the muscles soften and relax.", 
            "And close your eyes if you'd like to once more.", 
            "Breathing deeply in through the nose, ", 
            "and out through the mouth.", 
            "And just take a moment to pause, ",
            "allow the thoughts to come in and go,",
            "and then, gently opening the eyes again." 
        };
        float[] timestamps = { 0f, 3f, 7f, 11f, 14f, 19f, 21f, 24f, 28f, 31f, 36f, 38f, 42f, 46f, 49f, 51f, 54f, 56f};
        StartMeditation(bambooClip, phrases, timestamps); 
    }

    private void StartMeditation(AudioClip clip, string[] phrases, float[] times)
    {
        if (sessionCoroutine != null) StopCoroutine(sessionCoroutine);
        
        audioSource.clip = clip;
        
        MeditationSpaceController controller = FindObjectOfType<MeditationSpaceController>();
        if (controller != null)
        {
            controller.Activate();
        }

        sessionCoroutine = StartCoroutine(MeditationRoutine(clip, phrases, times));
    }

    IEnumerator MeditationRoutine(AudioClip clip, string[] phrases, float[] times)
    {
        subtitleText.text = ""; 

        // Silenciamos todo el juego
        AudioListener.pause = true;

        while (!audioSource.isPlaying) yield return null;

        for (int i = 0; i < phrases.Length; i++)
        {
            while (audioSource.time < times[i]) yield return null;
            
            subtitleText.text = phrases[i];
            subtitleText.canvasRenderer.SetAlpha(0f);
            subtitleText.CrossFadeAlpha(1f, 0.5f, false);
        }

        while (audioSource.isPlaying) yield return null;
        
        // Reactivamos todos los sonidos del juego al terminar
        AudioListener.pause = false;

        subtitleText.CrossFadeAlpha(0f, 1f, false);
        yield return new WaitForSeconds(1f);
        subtitleText.text = "";
    }

    public void StopMeditation()
    {
        StopAllCoroutines();
        audioSource.Stop();
        AudioListener.pause = false; // Aseguramos que el sonido vuelva si se cancela
        subtitleText.text = "";
    }
}