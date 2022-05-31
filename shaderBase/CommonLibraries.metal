//
//  CommonLibraries.metal
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#include <metal_stdlib>
using namespace metal;



float noise21(float2 uv)
{
  return  fract(sin(uv.x*500+ uv.y*374)*7363);
}

float3 circle(float2 uv, float scale=0.005)
{
  float d = length(uv);
  return float3(scale/d);
}

float smoothNoise(float2 uv, int m=10) {
  float2 lv = smoothstep(0,1,fract(uv*m));
  float2 id = floor(uv*m);
  
  float bl = noise21(id);
  float br = noise21(id + float2(1,0));
  float b = mix(bl, br, lv.x);
  
  float tl = noise21(id + float2(0,1));
  float tr = noise21(id + float2(1,1));
  float t = mix(tl, tr, lv.x);
  
  float r = mix(b,t,lv.y);
  return r;
}
