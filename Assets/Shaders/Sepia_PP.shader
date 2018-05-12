Shader "CustomPostProcess/Sepia_PP" {
	Properties {
		_Contrast("Contrast", Range(0, 30)) = 0
		_MainTex("MainTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;
			half _Contrast;

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);

				_Contrast = 30 - _Contrast;
				c = 1 / (1 + exp(-1 * _Contrast * (c - 0.5)));

				c.r = c.r*0.393 + c.g*0.769 + c.b*0.189;
                c.g = c.r*0.349 + c.g*0.686 + c.b*0.168;
                c.b = c.r*0.272 + c.g*0.534 + c.b*0.131;

				return c;
			}
			ENDCG
		}
	}
}