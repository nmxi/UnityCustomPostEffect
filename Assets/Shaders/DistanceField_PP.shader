Shader "CustomPostProcess/DistanceField_PP" {
	Properties {
		_Distance("Distance", Range(0, 1)) = 0
		_MainTex("MainTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;
			half _Distance;

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);

			    float d = distance(float2(0.5, 0.5), i.uv);
			    if(d > _Distance){
			    	return 0;
			    }

				return c;
			}
			ENDCG
		}
	}
}