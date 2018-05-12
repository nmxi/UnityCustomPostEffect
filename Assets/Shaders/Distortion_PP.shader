Shader "CustomPostProcess/Distortion_PP" {
	Properties {
		_Speed("Speed", Range(0, 1)) = 1
		_Strength_1("Strengs 1", Range(0, 10)) = 1
		_Strength_2("Strengs 2", Range(0, 10)) = 1

		_MainTex("MainTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;

			half _Speed;
			half _Strength_1;
			half _Strength_2;

			fixed4 Frag(v2f_img i ) : COLOR {
				float2 st = i.uv;
				float x = 2 * st.y + sin(_Time.y * _Strength_1 * _Speed);
						st.x += sin(_Time.y * _Strength_2 * _Speed) * 0.1 *
                		sin(5 * x) * (- (x - 1) * (x - 1) + 1);

				fixed4 c = tex2D(_MainTex, st);

				return c;
			}
			ENDCG
		}
	}
}