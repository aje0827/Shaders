Shader "Custom/ LocalPositionColor"
{
	Properties{
		_Tint("Tint", Color) = (1,1,1,1)
	}

	SubShader{

		Pass{
			CGPROGRAM

			#pragma vertex Vert
			#pragma fragment Frag

			#include "UnityCG.cginc"

			float4 _Tint;

			struct Interpolators{
				float4 position : SV_POSITION;
				float3 localPosition : TEXCOORD0;
			};

			Interpolators Vert(float4 position : POSITION)
			{
				Interpolators i;
				i.localPosition = position.xyz;
				i.position = mul(UNITY_MATRIX_MVP, position);
				return i;
			}

			float4 Frag(Interpolators i) : SV_TARGET
			{
				return float4(i.localPosition + .5f, 1) * _Tint;
			}

			ENDCG
		}
	}
}