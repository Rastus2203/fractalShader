Shader "Custom/fractalShader" {

    Properties{
        cX("cX", Float) = -0.7
        cY("cY", Float) = 0.27

        maxIter("Max Iterations", Int) = 2000

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
                while ((depth < maxIter) && (pow(Z.x, 2) + pow(Z.y, 2) < 4) ) {
                    float2 oldZ = Z;

                    Z.x = pow(oldZ.x, 2) - pow(oldZ.y, 2) + cX;
                    Z.y = oldZ.x * oldZ.y * 2 + cY;


                    depth++;
                }


                if (depth == maxIter) {
                    //return half4(0, 1, 0, 1);
                }


                return half4(float(depth) / maxIter, 0, 0, 1);
            }


            ENDCG
        }
    }
}
