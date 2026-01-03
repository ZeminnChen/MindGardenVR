using UnityEngine;
using TMPro; // Si usas TextMeshPro, si no usa UnityEngine.UI;
using UnityEngine.UI;
using System.Collections;

public class NotificationHandler : MonoBehaviour
{
    public Text notificationText; // Arrastra aquí tu componente de texto

    public void ShowNotification(string plantName)
    {
        // Cambia el texto dinámicamente
        notificationText.text = plantName + " x1";
        
        // Activa el objeto y gestiona el tiempo
        gameObject.SetActive(true);
        StopAllCoroutines(); 
        StartCoroutine(HideAfterTime());
    }

    IEnumerator HideAfterTime()
    {
        yield return new WaitForSeconds(2f);
        gameObject.SetActive(false);
    }
}