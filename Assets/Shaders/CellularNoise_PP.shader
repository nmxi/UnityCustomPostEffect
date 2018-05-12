Shader "CustomPostProcess/CellularNoise" {
	Properties {
		_Scale("Scale", Range(0, 10)) = 1
		_Strength("Strength", Range(0, 1)) = 0
		_MainTex("MainTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;

			half _Scale;
			half _Strength;

			float Rand(float2 st){
   				return frac(sin(dot(st, float2(12.9898, 78.233))) * 43758.5453);
			}

			fixed4 Frag(v2f_img i ) : COLOR {
				//fixed4 c = tex2D(_MainTex, i.uv);

				fixed2 st = 

				st = st * 3. * _Scale;
				fixed2 i_st = floor(st);
				fixed2 f_st = frac(st);

				fixed2 p = Rand(i_st);

				fixed2 diff = p - f_st;
				fixed dist = length(diff);

				return fixed4(dist, dist, dist, 1);
			}
			ENDCG
		}
	}
}