Shader "Custom/fractalShader" {

    Properties{
        cX("cX", Float) = -0.7
        cY("cY", Float) = 0.27

        maxIter("Max Iterations", Int) = 200

    }

    SubShader{
        Pass {
            CGPROGRAM

            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag

            int maxIter;
            float cX;
            float cY;


            struct vertInput {
                float4 pos : POSITION;
            };


            struct vertOutput {
                float4 pos : SV_POSITION;
                float4 screenPos : TEXCOORD0;
            };


            vertOutput vert(vertInput input) {
                vertOutput o;
                o.pos = UnityObjectToClipPos(input.pos);
                o.screenPos = ComputeScreenPos(o.pos);

                return o;
            }





            half4 frag(vertOutput output) : COLOR{
                float2 position;
                //Normalise position to 0 -> 1
                position = output.screenPos.xy / output.screenPos.w;
                //Change range to -1 -> 1
                float2 Z = (position - float2(0.5, 0.5)) * 2;
                //float2 Zinit = Z;

                int depth = 0;
                while ((Z.x * Z.x) + (Z.y * Z.y) < 4 && depth < maxIter) {
                    float tmp = Z.x * Z.x - Z.y * Z.y;
                    Z.y = 2 * Z.x * Z.y + cY;
                    Z.x = tmp + cX;

                    depth++;
                }





                return half4(depth / maxIter, 0, 0, 1);
            }


            ENDCG
        }
    }
}
