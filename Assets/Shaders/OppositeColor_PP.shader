Shader "CustomPostProcess/OppositeColor_PP" {
	Properties {
		_Strength("Strength", Range(0, 1)) = 1
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
				c = abs(_Strength - c);

				return c;
			}
			ENDCG
		}
	}
}