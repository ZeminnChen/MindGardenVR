using UnityEngine;
using UnityEngine.UI; 

public class MeditationHandler : MonoBehaviour
{
    [Header("Audio config")]
    public AudioSource sourceAudio;
    public AudioClip loto;
    public AudioClip zen;
    public AudioClip bamboo;

    public void ReproduceLoto() { ReproduceAudio(loto); }
    public void ReproduceBamboo() { ReproduceAudio(bamboo); }
    public void ReproduceZen (){ ReproduceAudio(zen); }

    private void ReproduceAudio(AudioClip clip)
    {
        if (sourceAudio != null && clip != null)
        {
            if (sourceAudio.clip == clip && sourceAudio.isPlaying) return;

            sourceAudio.Stop(); 
            sourceAudio.clip = clip;
            sourceAudio.loop = true;
            sourceAudio.Play();
        }
    }

    public void StopAudio()
    {
        if (sourceAudio != null) sourceAudio.Stop();
    }
}