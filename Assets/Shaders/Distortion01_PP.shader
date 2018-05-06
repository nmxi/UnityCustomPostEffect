Shader "CustomPostProcess/Distortion01_PP" {
	Properties {
		_Strength("Strength", Range(0, 10)) = 10
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

			fixed4 Frag(v2f_img i ) : COLOR {
				float2 st = i.uv;
				st -= 0.5;
				st *= 1.0 + 15 * pow(length(i.uv - 0.5), _Strength);
				st += 0.5;

				fixed4 c = tex2D(_MainTex, st);

				return c;
			}
			ENDCG
		}
	}
}