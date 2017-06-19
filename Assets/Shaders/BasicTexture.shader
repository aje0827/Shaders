Shader "Custom/ Basic Texture"
{
	Properties{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex ("Texture", 2D) = "white" {}
	}

	SubShader{

		Pass{
			CGPROGRAM

			#pragma vertex Vert
			#pragma fragment Frag

			#include "UnityCG.cginc"

			float4 _Tint;
			sampler2D _MainTex;
			float4 _MainTex_ST;

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
//				i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return i;
			}

			float4 Frag(Interpolators i) : SV_TARGET
			{
				return tex2D(_MainTex, i.uv) * _Tint;
			}

			ENDCG
		}
	}
}