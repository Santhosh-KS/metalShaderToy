//
//  CloudEffect.metal
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

float interestingPattern() {
    //  float3 c1 = fract((tan(uv.x*100) * tan(uv.y*100))*5);
    //  float3 c2 = fract((tan(uv.x*100) / tan(uv.y*100))*5);
    //  float3 c = mix(c1,c2, 1);
    //  float3 c = fract((sin(uv.x*100) / cos(uv.y*100))*4);
    //  uv = noise21(uv);
    //  col = float3(uv,0);
    //  col = circle(uv);
  return  0.0;
}



float octaveOfNoise(float2 uv) {
  float r = smoothNoise(uv,8);
  r += smoothNoise(uv,16)*0.5;
  r += smoothNoise(uv,32)*0.25;
  r += smoothNoise(uv,64)*0.125;
  r += smoothNoise(uv,128)*0.0625;
  r /= 2.5; // normalize
  return r;
}

//fragment float4 fragment_cloud_animations(constant ScreenDimensions &screen [[buffer(11)]],
//                              constant float &timer [[buffer(20)]],
//                              VertexOut in [[stage_in]])

float4 fragment_cloud_animations(float2 uv, float timer)
{
  uv += fract(float2(timer)*0.01);
  float3 col = float3(0);
  float r = octaveOfNoise(uv);
  col = float3(r);
  return float4(col,1);
}
