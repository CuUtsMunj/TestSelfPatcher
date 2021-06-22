Shader "Custom/ChromakeyTransparent" {
    Properties{
        _MainTex("Base (RGB)", 2D) = "white" {}
        _TransparentColourKey("Transparent Colour Key", Color) = (0,0,0,1)
        _TransparencyTolerance("Transparency Tolerance", Float) = 0.01
    }

        SubShader{
            Pass{
                Tags{ "RenderType" = "Opaque" }
                LOD 200

                CGPROGRAM

                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                struct a2v
                {
                    float4 pos : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct v2f
                {
                    float4 pos : SV_POSITION;
                    float2 uv : TEXCOORD0;
                };

                v2f vert(a2v input)
                {
                    v2f output;
                    output.pos = UnityObjectToClipPos(input.pos);
                    output.uv = input.uv;
                    return output;
                }

                sampler2D _MainTex;
                float3 _TransparentColourKey;
                float _TransparencyTolerance;

                float4 frag(v2f input) : SV_Target
                {
                    // What is the colour that *would* be rendered here?
                    float4 colour = tex2D(_MainTex, input.uv);

                    // Calculate the different in each component from the chosen transparency colour
                    float deltaR = abs(colour.r - _TransparentColourKey.r);
                    float deltaG = abs(colour.g - _TransparentColourKey.g);
                    float deltaB = abs(colour.b - _TransparentColourKey.b);

                    // If colour is within tolerance, write a transparent pixel
                    if (deltaR < _TransparencyTolerance && deltaG < _TransparencyTolerance && deltaB < _TransparencyTolerance)
                    {
                        return float4(0.0f, 0.0f, 0.0f, 0.0f);
                    }

                    // Otherwise, return the regular colour
                    return colour;
                }
                ENDCG
            }
        }
}
————————————————
版权声明：本文为CSDN博主「新媒体」的原创文章，遵循CC 4.0 BY - SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https ://blog.csdn.net/dark00800/article/details/70314432