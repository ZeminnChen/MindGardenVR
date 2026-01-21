using UnityEngine;
using UnityEngine.InputSystem;

// Aseg�rate de que este script requiere el CharacterController para evitar errores.
[RequireComponent(typeof(CharacterController))]
public class VrCommands : MonoBehaviour
{
    // Variables de control de rotaci�n (mantenidas)
    public float rotationSpeed = 30.0f;

    // --- Variables de Teletransporte ---
    public float maxTeleportDistance = 20.0f;
    [Tooltip("La capa que representa el suelo o superficies a las que se puede teletransportar.")]
    public LayerMask teleportLayerMask;

    // Referencias
    private CharacterController characterController;
    private Transform mainCameraTransform;

    // Variables de Input
    public MyPlayerControlls controls;
    private Vector2 lookInput;
    private bool teleportTriggered; // Usamos esto para detectar la pulsaci�n/soltura

    private void Awake()
    {
        characterController = GetComponent<CharacterController>();
        mainCameraTransform = Camera.main.transform;

        controls = new MyPlayerControlls();
        controls.MyPlayer.Look.performed += OnLookPerformed;
        controls.MyPlayer.Look.canceled += OnLookCanceled;

        // CAMBIO CLAVE: El teletransporte se inicia al presionar (started)
        // y se ejecuta al soltar (canceled) la tecla 'MoveForward'.
        controls.MyPlayer.MoveForward.started += ctx => teleportTriggered = true;
        controls.MyPlayer.MoveForward.canceled += ctx => TeleportPlayer();
    }

    private void OnLookPerformed(InputAction.CallbackContext context)
    {
        lookInput = context.ReadValue<Vector2>();
    }

    private void OnLookCanceled(InputAction.CallbackContext context)
    {
        lookInput = Vector2.zero;
    }

    private void OnEnable() => controls.Enable();

    private void OnDisable() => controls.Disable();

    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
        if (mainCameraTransform.parent != transform)
        {
            Debug.LogWarning("La c�mara principal no es hija del Player. La rotaci�n de mirada vertical no funcionar� correctamente.");
        }
    }

    void Update()
    {
        // 1. Rotaci�n de la Mirada (Ejes X y Y)
        HandleRotation();
    }

    private void HandleRotation()
    {
        // Rotaci�n Horizontal (Y) en el Player
        transform.Rotate(0, lookInput.x * rotationSpeed * Time.deltaTime, 0);

        // Rotaci�n Vertical (X) en la C�mara
        if (mainCameraTransform != null && mainCameraTransform.parent == transform)
        {
            mainCameraTransform.localRotation *= Quaternion.Euler(-lookInput.y * rotationSpeed * Time.deltaTime, 0, 0);
            ClampCameraRotation(mainCameraTransform);
        }
    }

    private void TeleportPlayer()
    {
        // Se ejecuta solo una vez al soltar la tecla
        Debug.Log("Intentando Teletransportar...");
        if (!teleportTriggered) return;
        teleportTriggered = false;

        RaycastHit hit;

        // El Raycast se dispara desde la posici�n y direcci�n de la c�mara (la mirada).
        if (Physics.Raycast(mainCameraTransform.position, mainCameraTransform.forward, out hit, maxTeleportDistance, teleportLayerMask))
        {
            // La altura a mantener: la mitad de la altura del CharacterController m�s el skin.
            float playerHeightOffset = characterController.height / 2f + characterController.skinWidth;

            Vector3 newPosition = hit.point;
            newPosition.y += playerHeightOffset;

            // Movimiento instant�neo con CharacterController:
            // 1. Deshabilitar para evitar problemas de colisi�n al teletransportar.
            characterController.enabled = false;
            // 2. Teletransportar.
            transform.position = newPosition;
            // 3. Habilitar de nuevo.
            characterController.enabled = true;

            Debug.Log($"Teletransportado a {newPosition}");
        }
    }

    // Funci�n de ayuda opcional para limitar la rotaci�n vertical de la c�mara (mantenida)
    void ClampCameraRotation(Transform cameraTransform)
    {
        Vector3 currentRotation = cameraTransform.localEulerAngles;
        if (currentRotation.x > 180) currentRotation.x -= 360;
        currentRotation.x = Mathf.Clamp(currentRotation.x, -80f, 80f);
        currentRotation.y = 0;
        currentRotation.z = 0;
        cameraTransform.localEulerAngles = currentRotation;
    }
}