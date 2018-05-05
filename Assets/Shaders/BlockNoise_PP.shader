Shader "CustomPostProcess/RandomColorAmeba_PP" {
	Properties {
		_Strength("Strength", Range(0.01, 2000)) = 1
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

        	float noise(fixed2 st){
	            fixed2 p = floor(st);
	            return random(p);
        	}

			fixed4 Frag(v2f_img i ) : COLOR {
				float3 c = tex2D(_MainTex, i.uv);
				float3 st = frac(c * _Strength);
				return float4(st.r, st.g, st.b, 1);

			}
			ENDCG
		}
	}
}