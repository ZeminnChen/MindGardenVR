using UnityEngine;
using TMPro;
using System.Collections;

public class PurchaseHandler : MonoBehaviour
{
    [Header("Notification UI")]
    public GameObject notificationCanvas;
    public TextMeshProUGUI notificationText;
    
    [Header("Seed Settings")]
    public string seedName;
    private bool isPurchased = false;

    public void ExecutePurchase()
    {
        // Prevent multiple purchases if the user keeps looking at the object
        if (isPurchased) return;

        isPurchased = true;
        Debug.Log("!!! PURCHASE SUCCESSFUL: " + seedName + " !!!");

        // Show the UI notification
        if (notificationCanvas != null && notificationText != null)
        {
            notificationText.text = "You bought " + seedName + "!";
            notificationCanvas.SetActive(true);
            
            // Restart the hide timer in case another notification was active
            StopAllCoroutines(); 
            StartCoroutine(HideNotification());
        }
    }

    private IEnumerator HideNotification()
    {
        yield return new WaitForSeconds(2.5f);
        notificationCanvas.SetActive(false);
    }
}