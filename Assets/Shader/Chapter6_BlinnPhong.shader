﻿// Blinn-Phong光照模型

Shader "UnityShadersBook/Chapter6/BlinnPhong" {
	Properties{
		_Diffuse("Diffuse", Color) = (1,1,1,1)
		_Specular("Specular", Color) = (1,1,1,1)
		_Gloss("Gloss", Range(8.0, 256)) = 20
	}
		SubShader{
		Pass{

		Tags{ "LightMode" = "ForwardBase" }

		CGPROGRAM

#pragma vertex vert
#pragma fragment frag
#include "Lighting.cginc"

		fixed4 _Diffuse;
	fixed4 _Specular;
	float _Gloss; // 范围比较大 所以用float

	struct a2v {
		float4 vertex : POSITION;
		float3 normal :	NORMAL;
	};

	struct v2f {
		float4 pos : SV_POSITION;
		float3 worldNormal : TEXCOORD0;
		float3 worldPos : TEXCOORD1;
	};

	v2f vert(a2v v) {
		v2f o;
		o.pos = UnityObjectToClipPos(v.vertex);

		o.worldNormal = mul(v.normal, (float3x3)unity_WorldToObject);
		o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

		return o;
	}

	fixed4 frag(v2f i) : SV_Target{
		fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz; // 得到环境光

		fixed3 worldNormal = normalize(i.worldNormal);
		fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

		fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLightDir)); // 漫反射光

		fixed3 reflectDir = normalize(reflect(-worldLightDir, worldNormal));
		fixed3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.worldPos.xyz);
		fixed3 halfDir = normalize(worldLightDir + viewDir);
		fixed3 specular = _LightColor0.rgb * _Specular.rgb * pow(max(0,dot(worldNormal,halfDir)), _Gloss); // 高光反射

		return fixed4(ambient + diffuse + specular, 1.0);
	}

		ENDCG
	}
	}
		FallBack "Specular"
}
