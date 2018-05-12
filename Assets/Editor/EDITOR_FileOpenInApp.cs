using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using System.Diagnostics;

public class EDITOR_FileOpenInApp: EditorWindow {

	[MenuItem("Assets/Open in System Default Application %#o")]
	private static void GetSelectFile(){
		
		if(Selection.assetGUIDs != null && Selection.assetGUIDs.Length > 0){
			List<string> fileList = new List<string>();
     
			foreach(var files in Selection.assetGUIDs){
				var path = AssetDatabase.GUIDToAssetPath(files);
				fileList.Add(path);
			}

			foreach (string directory in fileList) {
				Command("open " + Application.dataPath + directory.Substring(6, directory.Length - 6));
			}
		}
	}

	static string Command(string cmd){
		var p = new Process();
		p.StartInfo.FileName = "/bin/bash";
		p.StartInfo.Arguments = "-c \" " + cmd + " \"";
		p.StartInfo.UseShellExecute = false;
		p.StartInfo.RedirectStandardOutput = true;
		p.Start();

		var output = p.StandardOutput.ReadToEnd();
		p.WaitForExit();
		p.Close();

		return output;
	}
}
