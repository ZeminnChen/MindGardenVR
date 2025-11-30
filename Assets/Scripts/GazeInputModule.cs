using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class GazeInputModule : PointerInputModule
{
    // ----------------------------------------------------------------------
    // PROPIEDADES PÚBLICAS (Configuración en el Inspector)
    // ----------------------------------------------------------------------

    [Header("Configuración del Gaze")]
    [Tooltip("Tiempo, en segundos, que el usuario debe mirar para simular un clic.")]
    public float GazeTime = 4.0f;

    [Tooltip("Tiempo de gracia (segundos) antes de confirmar que la mirada se perdió y reiniciar el temporizador.")]
    public float GazeLossGracePeriod = 0.2f;

    [Tooltip("Referencia al puntero (Reticle) que se usa para la mirada. (Opcional)")]
    public GameObject Reticle;

    // ----------------------------------------------------------------------
    // PROPIEDADES PRIVADAS
    // ----------------------------------------------------------------------

    private float timer = 0.0f;
    private float gazeLostTimer = 0.0f;
    private bool isGazing = false;
    private GameObject currentLookAt;
    private GameObject lastLookAt;

    private const int GazePointerId = kMouseLeftId;

    private PointerEventData GetGazePointerData(int id)
    {
        PointerEventData data;
        GetPointerData(id, out data, true);
        return data;
    }

    // ----------------------------------------------------------------------
    // UNITY LIFECYCLE Y PROCESAMIENTO
    // ----------------------------------------------------------------------

    public override bool ShouldActivateModule()
    {
        // Devolvemos true para asegurar que este módulo siempre esté activo.
        return true;
    }

    public override void Process()
    {
        // 1. Detección del objeto interactivo bajo la mirada.
        HandleGazeDetection();

        // 2. Procesar el temporizador.
        HandleGazeTimer();

        // 3. Gestionar el feedback visual.
        HandleVisualFeedback();
    }

    private void HandleGazeDetection()
    {
        PointerEventData pointerEvent = GetGazePointerData(GazePointerId);
        pointerEvent.position = new Vector2(Screen.width / 2, Screen.height / 2);

        // Realizar Raycast en la escena para la UI
        eventSystem.RaycastAll(pointerEvent, m_RaycastResultCache);
        RaycastResult raycast = FindFirstRaycast(m_RaycastResultCache);
        pointerEvent.pointerCurrentRaycast = raycast;
        m_RaycastResultCache.Clear();

        GameObject lookAtRaw = pointerEvent.pointerCurrentRaycast.gameObject;
        GameObject lookAtFinal = null;

        if (lookAtRaw != null)
        {
            // Intentar encontrar el componente interactivo (Button o EventTrigger) en lookAtRaw o su padre.

            // Empezar la búsqueda desde el objeto golpeado
            Transform currentTransform = lookAtRaw.transform;

            while (currentTransform != null)
            {
                Button btn = currentTransform.GetComponent<Button>();
                EventTrigger trigger = currentTransform.GetComponent<EventTrigger>();

                // Si encontramos un Button o EventTrigger, este es el objeto final.
                if (btn != null || trigger != null)
                {
                    lookAtFinal = currentTransform.gameObject;
                    break;
                }

                // Subir al siguiente padre
                currentTransform = currentTransform.parent;
            }
        }

        // Si el objeto final cambia (o se pierde el objeto interactivo)
        if (lookAtFinal != currentLookAt)
        {
            // La mirada ha cambiado a otro objeto interactivo o se ha perdido.
            ResetGaze();
            currentLookAt = lookAtFinal;
        }

        // Si currentLookAt NO es nulo, estamos mirando un objeto INTERACTIVO.
        if (currentLookAt != null)
        {
            isGazing = true;
            Debug.Log("Detector de Gaze: ¡GOLPE EN OBJETO FINAL! Nombre: " + currentLookAt.name);
        }
        else
        {
            isGazing = false;
        }
    }

    private void HandleVisualFeedback()
    {
        if (currentLookAt != lastLookAt)
        {
            // 1. Restaurar el objeto anterior (si existe)
            if (lastLookAt != null)
            {
                VisualFeedback oldFeedback = lastLookAt.GetComponent<VisualFeedback>();
                if (oldFeedback != null)
                {
                    oldFeedback.SetGazeActive(false);
                }
            }

            // 2. Aplicar el feedback al nuevo objeto (si existe)
            if (currentLookAt != null)
            {
                VisualFeedback newFeedback = currentLookAt.GetComponent<VisualFeedback>();
                if (newFeedback != null)
                {
                    newFeedback.SetGazeActive(true);
                }
            }

            // 3. Actualizar la referencia para el próximo ciclo
            lastLookAt = currentLookAt;
        }
    }

    private void HandleGazeTimer()
    {
        if (isGazing) // Si estamos mirando un objeto INTERACTIVO
        {
            // Reiniciar el temporizador de pérdida de gracia (ya que estamos mirando algo)
            gazeLostTimer = 0.0f;

            // Aumentar el temporizador principal
            timer += Time.unscaledDeltaTime;

            Debug.Log("Temporizador Gaze: " + timer.ToString("F2") + " / " + GazeTime.ToString("F2"));

            if (timer >= GazeTime)
            {
                Debug.Log("Detector de Gaze: TIEMPO COMPLETADO. Simular clic en " + currentLookAt.name);
                PressGazeObject(currentLookAt);
                ResetGaze();
            }
        }
        else // Si isGazing es false (el rayo golpeó el Canvas o nada, o se salió del Box Collider)
        {
            // Si el temporizador principal ya estaba en marcha, usamos el periodo de gracia.
            if (timer > 0.0f)
            {
                gazeLostTimer += Time.unscaledDeltaTime;

                // Si el tiempo de gracia se acaba, confirmamos la pérdida de mirada y reiniciamos el temporizador principal.
                if (gazeLostTimer >= GazeLossGracePeriod)
                {
                    ResetGaze();
                }
            }
        }
    }

    private void ResetGaze()
    {
        if (timer > 0.01f)
        {
            Debug.Log("Temporizador Gaze: REINICIADO (Mirada perdida/cambiada).");
        }
        timer = 0.0f;
        gazeLostTimer = 0.0f;
        currentLookAt = null; // Reiniciar la referencia de mirada.
        isGazing = false;
    }

    private void PressGazeObject(GameObject target)
    {
        if (target == null) return;

        PointerEventData pointerEvent = GetGazePointerData(GazePointerId);

        // Simular el ciclo completo del clic: Down, Click, Up
        ExecuteEvents.Execute(target, pointerEvent, ExecuteEvents.pointerDownHandler);
        ExecuteEvents.Execute(target, pointerEvent, ExecuteEvents.pointerClickHandler);
        ExecuteEvents.Execute(target, pointerEvent, ExecuteEvents.pointerUpHandler);
    }
}