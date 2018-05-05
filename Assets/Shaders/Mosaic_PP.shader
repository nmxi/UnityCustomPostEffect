Shader "CustomPostProcess/Mosaic_PP" {
	Properties {
		_Strength("Strength", Range(1, 300)) = 0
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

			float box(float2 st, float size){
			    size = 0.5 + size * 0.5;
			    st = step(st, size) * step(1.0 - st, size);
			    return st.x * st.y;
			}

			//https://qiita.com/aa_debdeb/items/f2f6c56bcbe3f3ae4a36

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed2 f = floor(i.uv * _Strength);
                fixed size = 1.0 / _Strength;

                fixed2 lb = f / _Strength; // left bottom
                fixed2 lt = lb + fixed2(0.0, size); // left top
                fixed2 rb = lb + fixed2(size, 0.0); //right bottom
                fixed2 rt = lb + fixed2(size, size); // right top

                return (tex2D(_MainTex, lb) + tex2D(_MainTex, lt) + tex2D(_MainTex, rb) + tex2D(_MainTex, rt)) / 4.0;
			}
			ENDCG
		}
	}
}