Shader "CustomPostProcess/Noise_PP" {
	Properties {
		_Strength("Strength", Range(0, 1)) = 0
		_NoiseColor("NoiseColor", Color) = (1, 1, 1, 1)
		_MainTex("MainTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;

			half _Strength;
			fixed4 _NoiseColor;

			float random (fixed2 p) { 
            	return frac(sin(dot(p, fixed2(12.9898,78.233))) * 43758.5453);
        	}

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);

				if(random(i.uv * _Time.z) < _Strength){
					half r = random(i.uv);
					c = _NoiseColor;
				}

				return c;
			}
			ENDCG
		}
	}
}