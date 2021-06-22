using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.IO;
using System;
using System.Diagnostics;
using Debug = UnityEngine.Debug;


public class LauncherUIHandler : MonoBehaviour
{
    public void OnPlayButtonClicked() 
    {
        string path = Environment.CurrentDirectory + "/MainApp/TestSimplePatch.exe";
        Debug.Log("cu doi"+path);
        Process.Start(path);
        
    }
}
