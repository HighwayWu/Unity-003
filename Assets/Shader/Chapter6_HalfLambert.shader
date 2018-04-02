﻿Shader "UnityShadersBook/Chapter6/HalfLambert" {
	Properties{
		_Diffuse("Diffuse", Color) = (1,1,1,1)
	}
		SubShader{
		Pass{

		Tags{ "LightMode" = "ForwardBase" }

		CGPROGRAM

#pragma vertex vert
#pragma fragment frag
#include "Lighting.cginc"

		fixed4 _Diffuse;

	struct a2v {
		float4 vertex : POSITION;
		float3 normal :	NORMAL;
	};

	struct v2f {
		float4 pos : SV_POSITION;
		float3 worldNormal : TEXCOORD0;
	};

	v2f vert(a2v v) {	// 顶点着色器不用计算光照模型 只用把世界空间下的法线传递给片元着色器
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);

		o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);

		return o;
	}

	fixed4 frag(v2f i) : SV_Target{
		fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

		fixed3 worldNormal = normalize(i.worldNormal);
		fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

		fixed3 halfLambert = dot(worldNormal, worldLightDir) * 0.5 + 0.5; // 采用halfLambert模型
		fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;

		fixed3 color = ambient + diffuse;

		return fixed4(color, 1.0);
	}

		ENDCG
	}
	}
	FallBack "Diffuse"
}
