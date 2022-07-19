Shader "Unlit/Zero2Shaders/UVAsColor"
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
                //use the TEXCOORD0 semantic to get the UV0 attribute 
                float2 uv : TEXCOORD0;


            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                //Use the TEXCOORD0 interpolator to pass the uv to the fragment shader
                //always in the object space, no need for fancy transformations
                float2 uv : TEXCOORD0;

            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                //pass uv along
                o.uv = v.uv;

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                //use uv as a color, i.uv is 2 parts, we need 4 parts, lets light up the blue at the top u
                return float4(i.uv, 1.0, 1.0);
            }
            // we are mapping a 2d rectangular texture to some other object so there will always be a "seam" where 1 becomes 0 again
            //if you are having texture problems you put the UV on the object and debug.
            ENDCG
        }
    }
}
