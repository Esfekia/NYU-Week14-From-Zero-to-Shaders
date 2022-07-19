Shader "Unlit/Zero2Shaders/WorldNormalAsColor"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                
                //use the NORMAL semantic to get the normal attribute 
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;

                //use TEXCOORD0 interpolator to interpolate normal to fragment shader
                float3 worldNormal: TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //https://docs.unity3d.com/Manual/SL-BuiltinFunctions.html

                //transform object normal to world by the model matrix and give us the world normal
                o.worldNormal = UnityObjectToWorldNormal(v.normal);

                //pass normal along
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // transform world normal to visible range (again change from -1,1 range to 0,1 range for colors)
                // gets vectorized and each component gets multiplied by 0.5 and then added 0.5
                float3 norm = i.worldNormal * 0.5f + 0.5f;

                //use world normal as a color 
                return float4 (norm, 1.0f);

                // the normals here are stuck to the world, not to the object! rotating the object won't change the colors!
            }
            ENDCG
        }
    }
}
