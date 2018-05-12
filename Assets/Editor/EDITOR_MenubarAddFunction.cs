using UnityEngine;
using UnityEditor; // 追加
using System.Collections;
using System.IO;

public class EDITOR_MenubarAddFunction {
    [MenuItem ("/Function/CreateDirectory")]
    static void CreateDirectory() {
        if (!Directory.Exists("Assets/Scenes"))
            AssetDatabase.CreateFolder( "Assets", "Scenes" );

        if (!Directory.Exists("Assets/Resources")){     
            AssetDatabase.CreateFolder("Assets", "Resources");       
            AssetDatabase.CreateFolder("Assets/Resources", "Images");
            AssetDatabase.CreateFolder("Assets/Resources", "Textures");
            AssetDatabase.CreateFolder("Assets/Resources", "Audio");
            
        } else {
            if (!Directory.Exists("Assets/Resources/Images"))
                AssetDatabase.CreateFolder("Assets/Resources", "Images");
            
            if (!Directory.Exists("Assets/Resources/Textures"))
                AssetDatabase.CreateFolder("Assets/Resources", "Textures");
            
            if (!Directory.Exists("Assets/Resources/Audio"))
                AssetDatabase.CreateFolder("Assets/Resources", "Audio");
        }
        
        if (!Directory.Exists("Assets/Prefabs"))
            AssetDatabase.CreateFolder( "Assets", "Prefabs" );
        
        if (!Directory.Exists("Assets/Scripts"))
            AssetDatabase.CreateFolder( "Assets", "Scripts" );
        
        if (!Directory.Exists("Assets/Shaders"))
            AssetDatabase.CreateFolder( "Assets", "Shaders" );
        
        if (!Directory.Exists("Assets/Materials"))
            AssetDatabase.CreateFolder( "Assets", "Materials" );
            
        Debug.Log("Create Directory is Done!");
    }
}