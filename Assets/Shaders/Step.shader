﻿Shader "Unlit/Zero2Shaders/Step"
{
    Properties
    {
        _EdgeThreshold("Step Threshold", Range(0,1)) = 0.5
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

            static const float PI = 3.14159265f;
            static const float PI_2 = PI*2;

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

            float _EdgeThreshold;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // a standard 1 to zero (white to black) color gradient is:
                //return i.uv.x;

                //step function as color from zero to one across a range
                // step function needs an edge threshold (0.5 in our case). 
                //anything under 0.5 is zero anything over 0.5. is a one.
                //this will give us half white half black.
                return step(_EdgeThreshold,i.uv.x);
            }
            ENDCG
        }
    }
}
