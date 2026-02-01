using UnityEngine;

public class Fly : MonoBehaviour
{
    [Header("Ajustes de Velocidad")]
    public float speed = 3.0f;
    public float rotationSpeed = 2.0f;

    [Header("Configuración de Vuelo")]
    public float frequency = 0.5f;
    public float magnitude = 1.0f;

    [Header("Límites de la Escena")]
    public Vector3 centerPoint = Vector3.zero; // El centro de donde no quieres que salgan
    public float maxDistance = 20.0f;          // Radio máximo de vuelo
    public float returnForce = 5.0f;           // Qué tan rápido giran para volver

    private float seed;

    void Start()
    {
        seed = Random.Range(0f, 100f);
    }

    void Update()
    {
        // 1. Movimiento constante hacia adelante
        transform.Translate(Vector3.forward * speed * Time.deltaTime);

        // 2. Comprobar si está fuera de los límites
        float distance = Vector3.Distance(transform.position, centerPoint);

        if (distance > maxDistance)
        {
            // --- MODO RETORNO ---
            // Si está lejos, calculamos la dirección hacia el centro
            Vector3 directionToCenter = centerPoint - transform.position;
            Quaternion targetRotation = Quaternion.LookRotation(directionToCenter);

            // Giramos gradualmente hacia el centro
            transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, returnForce * Time.deltaTime);
        }
        else
        {
            // --- MODO VUELO NATURAL (Perlin Noise) ---
            float noiseX = Mathf.PerlinNoise(Time.time * frequency, seed) - 0.5f;
            float noiseY = Mathf.PerlinNoise(seed, Time.time * frequency) - 0.5f;

            Vector3 rotationDelta = new Vector3(noiseX, noiseY, 0) * magnitude;
            transform.Rotate(rotationDelta * rotationSpeed * Time.deltaTime);
        }

        FixZRotation();
    }

    void FixZRotation()
    {
        Quaternion currentRotation = transform.rotation;
        Quaternion flatRotation = Quaternion.Euler(currentRotation.eulerAngles.x, currentRotation.eulerAngles.y, 0);
        transform.rotation = Quaternion.Lerp(currentRotation, flatRotation, Time.deltaTime);
    }

    // Esto sirve para ver el radio en el editor de Unity
    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.cyan;
        Gizmos.DrawWireSphere(centerPoint, maxDistance);
    }
}