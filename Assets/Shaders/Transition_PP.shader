Shader "CustomPostProcess/Transition_PP" {
	Properties {
		_Transition("Transition", Range(0, 1)) = 0
		_MainTex("MainTex", 2D) = ""{}
		_RuleTex("RuleTex", 2D) = ""{}
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;
			sampler2D _RuleTex;

			half _Transition;

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);
				fixed4 r = tex2D(_RuleTex, i.uv);

				half t = r.r * 0.3 + r.g * 0.6 + r.b * 0.1;

				if(_Transition > t){
					return 0;
				}

				return c;
			}
			ENDCG
		}
	}
}