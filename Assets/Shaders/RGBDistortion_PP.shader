Shader "CustomPostProcess/RGBDistortion_PP" {
	Properties {
		_Strength("Strength", Range(0, 1)) = 1
		_ColorDistortion("RGB Distortion", Vector) = (1, 1, 1, 0)
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
			fixed3 _ColorDistortion;

			fixed4 Frag(v2f_img i ) : COLOR {
				i.uv.x = i.uv.x + sin(_Time.w * 100)*.01 * _Strength;
				i.uv.y = i.uv.y + sin(_Time.w * 70)*.01 * _Strength;

				fixed4 c = fixed4(
					tex2D(_MainTex, i.uv * _ColorDistortion.x).r,
					tex2D(_MainTex, i.uv * _ColorDistortion.y).g,
					tex2D(_MainTex, i.uv * _ColorDistortion.z).b,1);

				return c;
			}
			ENDCG
		}
	}
}