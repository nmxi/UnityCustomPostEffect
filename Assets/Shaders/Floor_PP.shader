Shader "CustomPostProcess/Floor_PP" {
	Properties {
		_Strength("Strength", Range(1, 20)) = 10
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
				fixed4 c = tex2D(_MainTex, i.uv);

				c = c * _Strength;
				c = floor(c);
				c = c * _Strength;

				return c;
			}
			ENDCG
		}
	}
}