Shader "Unlit/Zero2Shaders/TextureColor"
{
    //pass a texture as a uniform property
    Properties
    {
        // myTexture, way to set up a default texture as white
        _MyTexture("My Tex", 2D) = "white"{}
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

            // work in normalized texture coordinates to make changes easy
            sampler2D _MyTexture;

            // Unity will automatically populate this float for with a scale and tile size variable
            // Two new controls for us in the inspector which will help us scale and tile our texture
            float4 _MyTexture_ST;
            

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //Apply the automatic texture scale and offset to the uv
                o.uv = TRANSFORM_TEX(v.uv, _MyTexture);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture using the hlsl function and the uv coordinate from the mesh
                float4 color = tex2D(_MyTexture, i.uv);
                return color;
            }
            ENDCG
        }
    }
}
