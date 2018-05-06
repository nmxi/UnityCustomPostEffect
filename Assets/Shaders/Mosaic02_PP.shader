Shader "CustomPostProcess/Mosaic02_PP" {
	Properties {
		_Strength("Strength", Range(1, 100)) = 1
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

			float Random (in fixed2 st) {
    			return frac(sin(dot(st.xy,
                         fixed2(12.9898,78.233)))
                 			* 43758.5453123);
			}

			fixed4 Frag(v2f_img i ) : COLOR {

				fixed2 f = floor(i.uv * _Strength);
                fixed size = 1.0 / _Strength;

                fixed2 v00 = f / _Strength; // left bottom
                fixed2 v10 = v00 + fixed2(0.0, size); // left top
                fixed2 v01 = v00 + fixed2(size, 0.0); //right bottom
                fixed2 v11 = v00 + fixed2(size, size); // right top

                return (tex2D(_MainTex, v00) + 
                		tex2D(_MainTex, v10) + 
            			tex2D(_MainTex, v01) + 
            			tex2D(_MainTex, v11)) / 4.0;
			}
			ENDCG
		}
	}
}