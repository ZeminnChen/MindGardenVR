using UnityEngine;
using UnityEngine.InputSystem;

// Asegura que el Player tenga el cuerpo físico necesario
[RequireComponent(typeof(CharacterController))]
public class VrCommands : MonoBehaviour
{
    [Header("Configuración de Movimiento")]
    public float rotationSpeed = 30.0f;

    [Header("Configuración de Teletransporte")]
    public float maxTeleportDistance = 20.0f;
    
    // IMPORTANTE: En el Inspector, pon esto en "Everything" para que el rayo no atraviese paredes
    public LayerMask teleportLayerMask; 

    // Referencias internas
    private CharacterController characterController;
    private Transform mainCameraTransform;

    // Variables de Input
    public MyPlayerControlls controls;
    private Vector2 lookInput;
    private bool teleportTriggered; 

    private void Awake()
    {
        characterController = GetComponent<CharacterController>();
        mainCameraTransform = Camera.main.transform;

        controls = new MyPlayerControlls();
        
        // Configurar los controles de mirada
        controls.MyPlayer.Look.performed += OnLookPerformed;
        controls.MyPlayer.Look.canceled += OnLookCanceled;

        // Configurar el teletransporte (presionar para preparar, soltar para ejecutar)
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
        // Ocultar el ratón para que no moleste
        Cursor.lockState = CursorLockMode.Locked;
        
        if (mainCameraTransform.parent != transform)
        {
            Debug.LogWarning("AVISO: La cámara principal no es hija del Player.");
        }
    }

    void Update()
    {
        HandleRotation();
    }

    private void HandleRotation()
    {
        // Rotar el cuerpo del personaje (Izquierda/Derecha)
        transform.Rotate(0, lookInput.x * rotationSpeed * Time.deltaTime, 0);

        // Rotar la cámara (Arriba/Abajo)
        if (mainCameraTransform != null && mainCameraTransform.parent == transform)
        {
            Vector3 currentRotation = mainCameraTransform.localEulerAngles;
            
            // Calculamos la nueva rotación
            float newRotationX = currentRotation.x - (lookInput.y * rotationSpeed * Time.deltaTime);
            
            // Ajustes matemáticos para evitar que el cuello gire 360 grados
            if (newRotationX > 180) newRotationX -= 360;
            newRotationX = Mathf.Clamp(newRotationX, -80f, 80f);
            
            mainCameraTransform.localEulerAngles = new Vector3(newRotationX, 0, 0);
        }
    }

    private void TeleportPlayer()
    {
        // Solo ejecutamos si se había presionado el botón antes
        if (!teleportTriggered) return;
        teleportTriggered = false;

        RaycastHit hit;

        // Lanzamos el rayo láser invisible
        if (Physics.Raycast(mainCameraTransform.position, mainCameraTransform.forward, out hit, maxTeleportDistance, teleportLayerMask))
        {
            // --- NUEVA PROTECCIÓN ANTI-PAREDES ---
            // Verificamos si lo que hemos tocado NO es el suelo.
            // Esto asume que tu suelo tiene la Layer llamada "Ground".
            if (hit.collider.gameObject.layer != LayerMask.NameToLayer("Ground"))
            {
                Debug.Log("¡No puedo teletransportarme ahí! Es una pared u obstáculo.");
                return; // Cancelamos el teletransporte
            }
            // -------------------------------------

            Debug.Log($"Teletransportando a: {hit.point}");

            // Calcular altura para no quedar enterrado en el suelo
            float playerHeightOffset = characterController.height / 2f + characterController.skinWidth;
            Vector3 newPosition = hit.point;
            newPosition.y += playerHeightOffset;

            // Truco para mover el CharacterController sin conflictos
            characterController.enabled = false; // Apagamos el cuerpo un milisegundo
            transform.position = newPosition;    // Nos movemos
            characterController.enabled = true;  // Lo encendemos de nuevo
        }
    }
}