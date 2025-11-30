using UnityEngine;
using UnityEngine.EventSystems;

public class VisualFeedback : MonoBehaviour
{
    // Solo se usa para almacenar la escala base.
    [HideInInspector]
    public Vector3 originalScale;

    // Este factor lo ajustaste tú (ej. 1.1)
    public float scaleFactor = 1.1f;

    void Start()
    {
        originalScale = transform.localScale;
    }

    // Método llamado por GazeInputModule para escalar.
    public void SetGazeActive(bool isActive)
    {
        if (isActive)
        {
            // Resaltar
            transform.localScale = originalScale * scaleFactor;
        }
        else
        {
            // Volver a la escala original
            transform.localScale = originalScale;
        }
    }
}