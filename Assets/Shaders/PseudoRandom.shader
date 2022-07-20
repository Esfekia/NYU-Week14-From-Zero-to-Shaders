Shader "Unlit/Zero2Shaders/PseudoRandom"
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
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            //thebookofshaders.com
            float random(float2 v)
            {
                // return a fractional valiue of whatever goes into it, always between 0 and 1
                return frac(sin(dot(v.xy, float2(12.9898, 78.233))) * 43758.5343123);
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use random as color
                return float4(random(i.uv + 1.0f +_Time.x),random(i.uv + 10.0f +_Time.x),random(i.uv + 100.f +_Time.x),1);
            }
            ENDCG
        }
    }
}
