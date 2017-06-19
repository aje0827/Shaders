Shader "Custom/ TextureCordinateColor"
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
				float2 uv : TEXCOORD0;
//				float3 localPosition : TEXCOORD0;
			};

			struct VertexData{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			Interpolators Vert(VertexData v)
			{
				Interpolators i;
//				i.localPosition = v.position.xyz;
				i.position = mul(UNITY_MATRIX_MVP, v.position);
				i.uv = v.uv;
				return i;
			}

			float4 Frag(Interpolators i) : SV_TARGET
			{
				return float4(i.uv, 1, 1) * _Tint;
			}

			ENDCG
		}
	}
}