using UnityEngine;
using System.Collections;

public class AutoDoor : MonoBehaviour
{
    private bool isOpen = false;
    public float openAngle = 90f; 
    public float smoothTime = 2f; 
    public float timeToClose = 3f; 

    [Header("Audio Settings")]
    public AudioSource audioSource;
    public AudioClip openSound;
    public AudioClip closeSound;

    private Quaternion targetRotation;
    private Quaternion closedRotation;

    void Start()
    {
        closedRotation = transform.rotation;
        targetRotation = closedRotation;
        
        if (audioSource == null) audioSource = GetComponent<AudioSource>();
    }

    void Update()
    {
        transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, Time.deltaTime * smoothTime);
    }

    public void OpenDoor()
    {
        if (!isOpen)
        {
            isOpen = true;
            Vector3 directionToPlayer = Camera.main.transform.position - transform.position;
            float dot = Vector3.Dot(transform.forward, directionToPlayer);

            float finalAngle = (dot >= 0) ? -openAngle : openAngle;
            targetRotation = closedRotation * Quaternion.Euler(0, finalAngle, 0);
            
            if (audioSource && openSound) audioSource.PlayOneShot(openSound);

            StartCoroutine(WaitAndClose());
        }
    }

    IEnumerator WaitAndClose()
    {
        yield return new WaitForSeconds(timeToClose);

        targetRotation = closedRotation;
        isOpen = false;
        if (audioSource && closeSound) audioSource.PlayOneShot(closeSound);
    }
}