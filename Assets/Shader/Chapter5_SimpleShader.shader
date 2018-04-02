Shader "UnityShadersBook/Chapter5/SimpleShader" {
	Properties{
		_Color("Color Tint", Color) = (1.0,1.0,1.0,1.0)
	}

	SubShader{
		Pass {
			CGPROGRAM

			#pragma vertex vert		// 告诉Unity vert是顶点着色器
			#pragma fragment frag	// 告诉Unity frag是片元着色器

			fixed4 _Color;

			// 使用结构体来定义顶点着色器的输入
			struct a2v {
				float4 vertex : POSITION;	// 用模型空间的顶点坐标填充vertex
				float3 normal : NORMAL;		// 用模型空间的法线方向填充normal
				float4 texcoord : TEXCOORD0;// 用模型的第一套纹理坐标填充texcoord
			};
			
			// 定义顶点着色器的输出
			struct v2f {
				float4 pos : SV_POSITION;	// pos中包含了顶点在裁剪空间中的位置信息
				fixed3 color : COLOR0;
			};

			// Mesh Render负责在每帧调用Draw Call时将其需渲染的模型数据发送过来

			v2f vert(a2v v){
				v2f o;	//声明输出结构
				o.pos = UnityObjectToClipPos(v.vertex);
				// v.normal 包含了顶点的法线方向，其分量范围在[-1,1]
				// 将其映射到[0,1]后 储存到o.color 然后传递给片元着色器
				o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
				return o;
			}

			float4 frag(v2f i) : SV_Target {	// SV_Target: 把用户的输出颜色储存到默认的帧缓存中
				fixed3 c = i.color;
				c *= _Color.rgb;
				return fixed4(c, 1.0);	// 将插值后的i.color显示到屏幕上
			}
			
			ENDCG
		}
	}
}
