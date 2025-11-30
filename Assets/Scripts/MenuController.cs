using UnityEngine;
using UnityEngine.SceneManagement; 

public class MenuPrincipal : MonoBehaviour
{

    public void changeScene (string scene)
    {
        SceneManager.LoadScene(scene);
    }

    public void exitGame()
    {
        Debug.Log("Exit game.");
        Application.Quit();
    }
}