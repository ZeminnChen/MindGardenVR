using UnityEngine;
using UnityEngine.InputSystem;

// Asegúrate de que este script requiere el CharacterController para evitar errores.
[RequireComponent(typeof(CharacterController))]
public class VrCommands : MonoBehaviour
{
    // Variables de control de rotación (mantenidas)
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
    private bool teleportTriggered; // Usamos esto para detectar la pulsación/soltura

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
            Debug.LogWarning("La cámara principal no es hija del Player. La rotación de mirada vertical no funcionará correctamente.");
        }
    }

    void Update()
    {
        // 1. Rotación de la Mirada (Ejes X y Y)
        HandleRotation();
    }

    private void HandleRotation()
    {
        // Rotación Horizontal (Y) en el Player
        transform.Rotate(0, lookInput.x * rotationSpeed * Time.deltaTime, 0);

        // Rotación Vertical (X) en la Cámara
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

        // El Raycast se dispara desde la posición y dirección de la cámara (la mirada).
        if (Physics.Raycast(mainCameraTransform.position, mainCameraTransform.forward, out hit, maxTeleportDistance, teleportLayerMask))
        {
            // La altura a mantener: la mitad de la altura del CharacterController más el skin.
            float playerHeightOffset = characterController.height / 2f + characterController.skinWidth;

            Vector3 newPosition = hit.point;
            newPosition.y += playerHeightOffset;

            // Movimiento instantáneo con CharacterController:
            // 1. Deshabilitar para evitar problemas de colisión al teletransportar.
            characterController.enabled = false;
            // 2. Teletransportar.
            transform.position = newPosition;
            // 3. Habilitar de nuevo.
            characterController.enabled = true;

            Debug.Log($"Teletransportado a {newPosition}");
        }
    }

    // Función de ayuda opcional para limitar la rotación vertical de la cámara (mantenida)
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