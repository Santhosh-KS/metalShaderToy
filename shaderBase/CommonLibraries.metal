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

float2 noise22(float2 p)
{
  float3 a = fract(p.xyx*float3(123.34, 234.34, 345.65));
  a += dot(a, a+34.45);
  return  fract(float2(a.x*a.y,a.y*a.z));
}

float4 circle(float2 uv, float scale=0.005)
{
  float d = length(uv);
  float3 c(scale/d);
  return float4(c,1);
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

float4 grid(float2 uv) {
  float3 col(0);
  if(abs(uv.x)<fwidth(uv.x)) col.g = 1;
  if(abs(uv.y)<fwidth(uv.y)) col.r = 1.;
  float2 grid = 1.-abs(fract(uv)-.5)*2.;
  grid = smoothstep(fwidth(grid), float2(0), grid);
  col += float3((grid.x+grid.y)*0.5);
  return float4(col*.5,1);
}

float point(float2 uv, float2 p) {
//  return smoothstep(.08,.06, length(uv-p));
  return smoothstep(0.8,0.7, floor(length(uv-p)*10));
}


float Xor(float a, float b) {
  return a*(1-b) + b*(1-a);
}
