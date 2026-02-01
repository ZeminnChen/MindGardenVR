using UnityEngine;

public class Fly : MonoBehaviour
{
    // Velocidad de avance
    public float speed = 2.0f;
    
    // Velocidad de giro (qué tan cerrado es el círculo)
    public float rotationSpeed = 50.0f;

    void Update()
    {
        // 1. Mover hacia adelante (eje Z del pájaro)
        transform.Translate(Vector3.forward * speed * Time.deltaTime);

        // 2. Girar sobre su propio eje (eje Y, como una peonza)
        transform.Rotate(Vector3.up * rotationSpeed * Time.deltaTime);
    }
}