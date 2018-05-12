Shader "CustomPostProcess/CustomNoise01_PP" {
	Properties {
		_Strength("Strength", Range(0, 1)) = 0
		_NoiseColor("NoiseColor", Color) = (1, 1, 1, 1)
		_BlockNum("BlockNum", Range(1, 300)) = 30

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
			fixed4 _NoiseColor;
			half _BlockNum;

			float random (fixed2 p) { 
            	return frac(sin(dot(p, fixed2(12.9898,78.233))) * 43758.5453);
        	}

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed4 c = tex2D(_MainTex, i.uv);

				if(random(i.uv * _Time.z) < _Strength){
					half r = random(i.uv);
					c = _NoiseColor;
				}

				fixed2 f = floor(i.uv * _BlockNum);
                fixed size = 1.0 / _BlockNum;

                fixed2 v00 = f / _BlockNum; // left bottom
                fixed2 v01 = v00 + fixed2(0.0, size); // left top
                fixed2 v10 = v00 + fixed2(size, 0.0); //right bottom
                fixed2 v11 = v00 + fixed2(size, size); // right top

				if(random(i.uv * _Time) < _Strength){
					half r = random(i.uv);
					c = _NoiseColor;
					return c;
				}

                c = (tex2D(_MainTex, v00) + 
                	tex2D(_MainTex, v01) + 
                	tex2D(_MainTex, v10) + 
                	tex2D(_MainTex, v11)) / 4.0;

				return c;
			}
			ENDCG
		}
	}
}