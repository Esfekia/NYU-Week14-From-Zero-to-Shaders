Shader "Unlit/Zero2Shaders/GradientNoise"
{
    Properties
    {
    }

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

             float random(float2 v)
            {
                // return a fractional valiue of whatever goes into it, always between 0 and 1
                return frac(sin(dot(v.xy, float2(12.9898, 78.233))) * 43758.5343123);
            }

            float2 randomDir(float2 v)
            {
                // -1 to 1 random direction
                return float2(random(v), random(v * 2.0f)) * 2.0f - 1.0f;
            }

            static const float2 s_dirs[4] = {
                float2(0.0, 0.0),
                float2(1.0, 0.0),
                float2(0.0, 1.0),
                float2(1.0, 1.0)
            };

            // take in a float2 value and give us a float noise value out
            float gradientNoise(float2 v)
            {
                // grab integer component, the whole number
                float2 i = floor(v);

                // grab the floating component
                float2 f = frac(v);

                // smooth curve based on this floating point component
                float2 s = smoothstep(0.0f,1.0f,f);

                // assign 4 random directions from this grid cell
                float2 randDir0 = randomDir(i + s_dirs[0]);
                float2 randDir1 = randomDir(i + s_dirs[1]);
                float2 randDir2 = randomDir(i + s_dirs[2]);
                float2 randDir3 = randomDir(i + s_dirs[3]);

                // get the current position in this cell
                float2 cellPosition0 = f - s_dirs[0];
                float2 cellPosition1 = f - s_dirs[1];
                float2 cellPosition2 = f - s_dirs[2];
                float2 cellPosition3 = f - s_dirs[3];

                // we take dot product of each of these positions against our random direction
                float p0 = dot(randDir0, cellPosition0);
                float p1 = dot(randDir1, cellPosition1);
                float p2 = dot(randDir2, cellPosition2);
                float p3 = dot(randDir3, cellPosition3);

                // bilinear lerp = lerping some other lerps
                return lerp(lerp(p0, p1, s.x), lerp(p2, p3, s.x), s.y);
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
                //use noise as color, shifting again to 0-1
                return gradientNoise(i.uv * 45) * 0.5f + 0.5f;
            }
            ENDCG
        }
    }
}
