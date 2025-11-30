using UnityEngine;
using UnityEngine.UI; 

public class MeditationHandler : MonoBehaviour
{
    public AudioSource backgroundMusic;

    public void StartMeditationClicked()
    {
        if (backgroundMusic != null)
        {
            backgroundMusic.Play();
        }
        else
        {
            Debug.LogError("Error.");
        }
        

        Debug.Log("Starting meditation.");
    }
}