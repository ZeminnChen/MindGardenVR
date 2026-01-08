using UnityEngine;

public class LanternAction : MonoBehaviour
{
    public Light lantern; 
    // public AudioSource meditationAudio; // Arrastra aquí tu clip de paz


    public void OnGazeClick()
    {
        if (lantern != null){
            lantern.enabled = true;
            Debug.Log("Linterna iluminada por Gaze!");
        }


        //if (meditationAudio != null && !meditationAudio.isPlaying){
            //meditationAudio.Play();
        //}
    }
}