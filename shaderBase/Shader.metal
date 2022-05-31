//
//  Shader.metal
//  metalShaderToy
//
//  Created by Santhosh K S on 30/05/22.
//

#include <metal_stdlib>
#include "Common.h"
using namespace metal;

struct VertexIn {
  float4 position [[attribute(0)]];
};

struct VertexOut {
  float4 position [[position]];
};

vertex float4 vertex_main(const VertexIn vertexIn [[stage_in]]) {
  return vertexIn.position;
}

float noise21(float2 uv)
{
  return  fract(sin(uv.x*500+ uv.y*374)*7363);
}

float3 circle(float2 uv, float scale=0.005)
{
  float d = length(uv);
  return float3(scale/d);
}

float2 screenResolution(float x, float y)
{
  return float2(0.5*x, 0.5*y);
}

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

float octaveOfNoise(float2 uv) {
  float r = smoothNoise(uv,8);
  r += smoothNoise(uv,16)*0.5;
  r += smoothNoise(uv,32)*0.25;
  r += smoothNoise(uv,64)*0.125;
  r += smoothNoise(uv,128)*0.0625;
  r /= 2.5;
  return r;
}

fragment float4 fragment_main(constant ScreenDimensions &screen [[buffer(11)]],
                              constant float &timer [[buffer(20)]],
                              VertexOut in [[stage_in]])
{
  float2 resolution = screenResolution(screen.width, screen.height);
  float2 uv = (in.position.xy-resolution)/ screen.width;
  uv += fract(float2(timer)*0.01);
  float3 col = float3(0);
  float r = octaveOfNoise(uv);
  col = float3(r);
  return float4(col,1);
}


