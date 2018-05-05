Shader "CustomPostProcess/CompoundEyes_PP" {
	Properties {
		_Strength("Strength", Range(1, 10)) = 0
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
				float2 st = frac(i.uv * _Strength);
				fixed4 c = tex2D(_MainTex, st.xy);

				return float4(c.r, c.g, c.b, 1);
			}
			ENDCG
		}
	}
}