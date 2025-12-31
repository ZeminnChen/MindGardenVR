using UnityEngine;

public class DynamicTimeCycle : MonoBehaviour
{
    [Header("Referencias")]
    public Light sunLight;
    public ParticleSystem stars; // Arrastra aquí tu sistema de partículas

    [Header("Velocidad del Tiempo")]
    public float daySpeed = 5.0f;
    public float nightSpeed = 25.0f;

    void Update()
    {
        // 1. Lógica de Rotación y Velocidad
        float currentAngle = sunLight.transform.eulerAngles.x;
        // Consideramos noche si el sol está por debajo del horizonte
        bool isNight = currentAngle > 180 && currentAngle < 355;

        float actualSpeed = isNight ? nightSpeed : daySpeed;
        sunLight.transform.Rotate(Vector3.right * actualSpeed * Time.deltaTime);

        // 2. Lógica de las Estrellas
        if (stars != null)
        {
            if (isNight && !stars.isPlaying)
            {
                stars.Play();
            }
            else if (!isNight && stars.isPlaying)
            {
                stars.Stop();
            }
        }

        // 3. Intensidad de la Luz (Suavizado)
        float targetIntensity = isNight ? 0f : 1f;
        sunLight.intensity = Mathf.Lerp(sunLight.intensity, targetIntensity, Time.deltaTime);
    }
}