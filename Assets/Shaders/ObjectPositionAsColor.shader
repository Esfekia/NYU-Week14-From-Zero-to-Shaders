Shader "Unlit/Zero2Shaders/ObjectPositionAsColor"
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
                // interpolator position semantic
                float3 objectPosition : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                // lets pass that object position to the frag shader (using xyz because float3!)
                // extra info: swizzling mask could be used any way, .xxx or .zyx for example
                o.objectPosition = v.vertex.xyz;
                
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // use object position as a color
                // incoming component is a xyz so it also needs the alpha
                return float4(i.objectPosition, 1.0);
            }
            ENDCG
        }
    }
}
