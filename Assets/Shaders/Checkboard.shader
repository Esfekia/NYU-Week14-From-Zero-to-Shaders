Shader "Unlit/Zero2Shaders/Checkerboard"
{
    Properties
    {
        _Frequency("Frequency", Range(1,1000)) = 1
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

            float _Frequency;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // instead of X in the sin wave, we can do the Y:
                // return sin(i.uv.y * PI_2 * _Frequency) *0.5f +0.5f;

                // but what if we multiply the X in SinWave with Y above?
                // checkerboard with hills and valleys, not sharp/distinct squares:
                // return sin(i.uv.x * PI_2 * _Frequency) * sin(i.uv.y * PI_2 * _Frequency) *0.5f +0.5f;
                
                // what if we remove the 0-1 range conversion and use the cross from Zero
                // as a negative or positive binary switch to make this black or white??
                return sin(i.uv.x * PI_2 * _Frequency) * sin(i.uv.y * PI_2 * _Frequency) > 0;

                // real, crisp checkerboard! this is called ""quantized", zero or one binary output

            }

            ENDCG
        }
    }
}
