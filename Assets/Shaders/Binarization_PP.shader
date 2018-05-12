Shader "CustomPostProcess/Binarization_PP" {
	Properties {
		_MainTex("MainTex", 2D) = ""{}
		_Threshold("Threshold", Range(0,1))= 0.0
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;
			half _Threshold;

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);
				float gray = c.r * 0.3 + c.g * 0.6 + c.b * 0.1;

				if( gray > _Threshold ){
					return 0;
				} 

				return 1;
			}
			ENDCG
		}
	}
}