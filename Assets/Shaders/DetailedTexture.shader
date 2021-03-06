﻿Shader "Custom/ Textured With Detail"
{
	Properties{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Texture", 2D) = "white" {}
		_DetailTex("Detail Texture", 2D) = "gray" {}
	}

	SubShader{

		Pass{
			CGPROGRAM

			#pragma vertex Vert
			#pragma fragment Frag

			#include "UnityCG.cginc"

			float4 _Tint;
			sampler2D _MainTex, _DetailTex;
			float4 _MainTex_ST, _DetailTex_ST;

			struct VertexData{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Interpolators{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvDetail : TEXCOORD1;
//				float3 localPosition : TEXCOORD0;
			};

			Interpolators Vert(VertexData v)
			{
				Interpolators i;
//				i.localPosition = v.position.xyz;
				i.position = mul(UNITY_MATRIX_MVP, v.position);
//				i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				i.uvDetail = TRANSFORM_TEX(v.uv, _DetailTex);
				return i;
			}

			float4 Frag(Interpolators i) : SV_TARGET
			{
				float4 color = tex2D(_MainTex, i.uv) * _Tint;
				color *= tex2D(_DetailTex, i.uvDetail) * unity_ColorSpaceDouble; //fixes darkening caused by using linear rendering
				return color;
			}

			ENDCG
		}
	}
}