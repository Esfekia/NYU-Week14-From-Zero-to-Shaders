Shader "Unlit/Zero2Shaders/ParameterColor"
{
    //Add uniform property to the inspector
    Properties
    {
        // name of the uniform property used in the shader and how it will be manifested in the unity editor
        _MyColor("My Cool Color", Color) = (1,0,0,1)
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
                float4 position : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            //declare the uniform in the shader
            float4 _MyColor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.position);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // use the property as color
                return _MyColor;
            }

            ENDCG
        }
    }
}
