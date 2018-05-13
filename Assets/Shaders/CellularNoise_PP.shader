Shader "CustomPostProcess/CellularNoise_PP" {
	Properties {
		_CellularNoiseScale("Cellular Noise Scale", Range(.1, 5)) = .5
		_AnimSpeed("AnimationSpeed", Range(0, 5)) = 1
		[MaterialToggle] _IsShowGrid ("Is show Grid", int) = 0
		[MaterialToggle] _IsUseCellularNoise ("Is show CelllarNoise", int) = 1
		_MosaicStrength("Mosaic Strength", Range(5, 500)) = 320
		_MosaicSizeParam("Distortion Level", Range(0, 10)) = 1.25
		_SizeAdjust("Size Adjustment", Range(0, 5)) = 2
	}
	SubShader {
		Pass {
			CGPROGRAM

			#include "UnityCG.cginc"

			#pragma vertex vert_img
			#pragma fragment Frag

			sampler2D _MainTex;

			half _CellularNoiseScale;
			half _AnimSpeed;
			int _IsShowGrid;
			int _IsUseCellularNoise;
			half _MosaicStrength;
			half _MosaicSizeParam;
			half _Param;
			half _SizeAdjust;

			float Rand(float2 st){
   				return frac(sin(dot(st, float2(12.9898, 78.233))) * 43758.5453);
			}

			fixed4 Frag(v2f_img i ) : COLOR {
				fixed2 st = i.uv;

				fixed4 color = fixed4(0, 0, 0, 1);

				st = st * 3. * _CellularNoiseScale;

				fixed2 i_st = floor(st);
				fixed2 f_st = frac(st);

				fixed m_dist = 1.;

				for (int y = -1; y <= 1; ++y){
					for (int x = -1; x <= 1; ++x){
						fixed2 n = fixed2(float(x), float(y));
						float2 p = Rand(i_st + n);
						p.y = .5 + .5 * sin(_Time.z * _AnimSpeed + 6.2831 * p);
						p.x = .5 + .5 * sin(_Time.z * _AnimSpeed + 3.9823 * p);
						fixed2 diff = n + p - f_st;
						fixed dist = length(diff);

						m_dist = min(m_dist, dist);
					}
				}
				
				m_dist = (_IsUseCellularNoise > 0.5) ? m_dist : 1;

				m_dist = m_dist + distance(fixed2(0, 0), fixed2(1, 1) * 1.25);

				fixed2 f = floor(i.uv * (_MosaicStrength * _SizeAdjust / m_dist));
                fixed size = _MosaicSizeParam / (_MosaicStrength);

                fixed2 v00 = f / (_MosaicStrength); // left bottom
                fixed2 v10 = v00 + fixed2(0.0, size); // left top
                fixed2 v01 = v00 + fixed2(size, 0.0); //right bottom
                fixed2 v11 = v00 + fixed2(size, size); // right top

                color = (tex2D(_MainTex, v00) + tex2D(_MainTex, v10) + tex2D(_MainTex, v01) + tex2D(_MainTex, v11)) / 4.0;

				color.r = (_IsShowGrid > 0.5) ? color.r + (step(.9, f_st.x) + step(.9, f_st.y)) : color;

                return color;
			}
			ENDCG
		}
	}
}