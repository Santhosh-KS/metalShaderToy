//
//  CircleEffects.metal
//  shaderBase
//
//  Created by Santhosh K S on 07/06/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

float4 circleEffect(float2 uv, float timer)
{
  float a = 3.145/4;
  float c = cos(a), s = sin(a);
  float2x2 rotation(c,-s,s,c);
  uv *= rotation;
  uv = uv*40;
  float2 gv = fract(uv)-0.5;
  float2 id = floor(uv);
  
  
  float m(0);
  float t = timer*0.05;
  for(float y = -1; y <=1; y++) {
    for(float x = -1; x <=1; x++) {
      float2 offset(x,y);
      float d = length(gv-offset);
      float dist = length(id+offset)*.2;
      float r = mix(0.3,1.5, sin(dist-t)*0.5+0.5);
        //      m += smoothstep(r, r*0.9, d);
      m = Xor(m, smoothstep(r, r*0.9, d));
    }
  }
  float3 col(0);
  col.rg = gv;
  col += m;//fmod(m, 2);
  return float4(col,1);
}
