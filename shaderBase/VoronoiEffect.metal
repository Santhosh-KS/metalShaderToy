//
//  VoronoiEffect.metal
//  shaderBase
//
//  Created by Santhosh K S on 07/06/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

float4 voronoiEffect(float2 uv, float timer)
{
  float3 col(0);
  uv *= 3;
  float m = 0;
  float t = timer*0.1;
  float mindist = 100;
  if (false) {
    for(int i(0); i<=50; i++) {
      float2 n =  noise22(float2(i));
      float2 p = sin(n*t);
      float d = length(uv-p);
      m += smoothstep(0.005, 0.003, d);
      if (d < mindist) {
        mindist = d;
      }
    }
  } else {
    uv *= 3;
    float2 gv = fract(uv)-0.5;
    float2 id = floor(uv);
    float2 cid(0);
    for(float y(-1); y<=1; y++) {
      for(float x(-1); x<=1; x++) {
        float2 offset(x,y);
        float2 n =  noise22(id + offset);
        float2 p = offset+sin(n*t)*0.5;
        float d = length(gv-p);
        if (d < mindist) {
          mindist = d;
          cid = id + offset;
        }
      }
    }
    col = float3(mindist);
    col *= float3(0.5,1,1);
      //    col.rg = cid*0.3;
  }
  return float4(col,1);
}

