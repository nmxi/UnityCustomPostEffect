Shader "CustomPostProcess/BlockNoise_PP" {
	Properties {
		_NoiseStrength("NoiseStrength", Range(1, 50)) = 1
		_MainTex("MainTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;

			half _NoiseStrength;

			float random (fixed2 p) {
            	return frac(sin(dot(p, fixed2(12.9898,78.233))) * 43758.5453);
        	}

        	float noise(fixed2 st){
	            fixed2 p = floor(st);
	            return random(p);
        	}

			fixed4 Frag(v2f_img i ) : COLOR {
				//fixed4 c = noise( i.uv * _NoiseStrength);

				float2 st = frac(i.uv * _NoiseStrength);
				return float4(st.x, st.y, 0, 1);

				//return c;
			}
			ENDCG
		}
	}
}