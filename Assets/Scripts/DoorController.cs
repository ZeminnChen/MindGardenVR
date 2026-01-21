using UnityEngine;
using System.Collections;

public class AutoDoor : MonoBehaviour
{
    public float openAngle = 90f;
    public float smoothTime = 2.5f;
    public float timeToClose = 3f;

    public AudioSource sourceAbrir;
    public AudioClip clipAbrir;

    private bool isOpen = false;
    private Quaternion closedRotation;
    private Quaternion targetRotation;

    void Start()
    {
        closedRotation = transform.rotation;
        targetRotation = closedRotation;
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

            Vector3 localPlayerPos = transform.InverseTransformPoint(Camera.main.transform.position);
            float side = (localPlayerPos.z >= 0) ? -1f : 1f;
            
            targetRotation = closedRotation * Quaternion.Euler(0, openAngle * side, 0);

            if (sourceAbrir && clipAbrir) sourceAbrir.PlayOneShot(clipAbrir);

            StopAllCoroutines();
            StartCoroutine(AutoCloseRoutine());
        }
    }

    IEnumerator AutoCloseRoutine()
    {
        yield return new WaitForSeconds(timeToClose);
        targetRotation = closedRotation;
        isOpen = false;
    }
}