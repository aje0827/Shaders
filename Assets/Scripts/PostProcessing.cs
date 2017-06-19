using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//[ExecuteInEditMode]
public class PostProcessing : MonoBehaviour {

	public Material mat;

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		//src is the fully rendered scene that you would normally send to the monitor
		//we are intercepting this so we can do a bit more work, before passing it on.

		Graphics.Blit (src, dest, mat);
	}
}
