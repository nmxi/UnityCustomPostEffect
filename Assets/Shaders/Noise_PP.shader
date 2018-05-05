Shader "CustomPostProcess/NoiseDisolve_PP" {
	Properties {
		_Strength("Strength", Range(0, 1)) = 0
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

			float random (fixed2 p) { 
            	return frac(sin(dot(p, fixed2(12.9898,78.233))) * 43758.5453);
        	}

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);

				if(random(i.uv) < _Strength){
					half r = random(i.uv);
					c = fixed4(0, 0, 0, 1);
				}

				return c;
			}
			ENDCG
		}
	}
}