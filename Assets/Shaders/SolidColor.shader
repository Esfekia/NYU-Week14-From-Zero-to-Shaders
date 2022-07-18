Shader "Unlit/Zero2Shaders/SolidColor"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            // vert and frag will be the functions that represent our vertex and fragment shaders
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            // the name that Unity gives to the mesh data coming in
            struct appdata
            {
                // position of our mesh 
                float4 position : POSITION;
            };

            // vertex to fragment struct
            struct v2f
            {
                // transform into clipspace system level position semantic - position to make triangles out of
                float4 vertex : SV_POSITION;
            };


            // o as in out of the vertex and i as in into the fragment.
            // shaderstage that is taking in vertex attributes (positions normals texcoords etc.) from the struct above
            v2f vert(appdata v)
            {
                // process whatevers in the appdata and pass along the data to be interpolated into different fragments
                v2f o;                
                o.vertex = UnityObjectToClipPos(v.position);
                return o;

            }

            // this will get a copy of v2f struct passed into it to try to figure out what color this pixel / fragment should be
            fixed4 frag(v2f i) : SV_Target
            {
                // return a color, rgba value (0-1), not (0-256!). fixed4 occupies less space than float4
                return float4(1.0, 1.0, 0.0, 1.0);
            }

            ENDCG
        }
    }
}
