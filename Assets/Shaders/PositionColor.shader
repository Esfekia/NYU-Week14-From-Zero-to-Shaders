Shader "Unlit/Zero2Shaders/WorldPositionAsColor"
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
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 worldPosition : TEXCOORD0;
                //Use TEXCOORD0 interpolator to pass object space position to fragment shader
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //https://docs.unity3d.com/Manual/SL-UnityShaderVariables.html
                //transform object space to world space (utilizing mul and the unity shader variable for this purpose)
                //then use the xyz from the float4 that will be created by mul()
                float4 ws = mul(unity_WorldToObject, v.vertex);
                o.worldPosition = ws.xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use position as a color
                // incoming component is a xyz so it also needs the alpha
                return float4(1-i.worldPosition*i.worldPosition, 1);
            }
            ENDCG
        }
    }
}
