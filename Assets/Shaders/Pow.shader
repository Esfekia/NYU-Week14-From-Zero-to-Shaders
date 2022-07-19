Shader "Unlit/Zero2Shaders/Pow"
{
    Properties
    {
        _Power("Power", Range(1,10)) = 1
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
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

            float _Power;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use pow function as color
                //return pow(i.uv.x, _Power);

                //creating a particle sprite for example
                //what if we took the length of uv minus float2 that was at the center?
                return pow(1-length(float2(0.5, 0.5)- i.uv), _Power);

            }
            ENDCG
        }
    }
}
