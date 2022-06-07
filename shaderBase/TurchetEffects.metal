//
//  TurchetEffects.metal
//  shaderBase
//
//  Created by Santhosh K S on 07/06/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

float4 truchetLinesPatternLedEdgeEffect(float2 uv)
{
  float3 col(0);
  uv *= 10;
  
  float2 gv = fract(uv)-0.5;
  float2 id = floor(uv);
  
  float n = noise21(id);
  if (n < 0.5 ) {
    gv.x *= -1;
  }
  
  float threshold(0.48);
  if (gv.x > threshold || gv.y > threshold) col = float3(1,0,0);
  float width(0.05);
  float mask = smoothstep(0.01,-0.01, abs(gv.x + gv.y)-width);
  
  
    //  col += n;
  col += mask;
  return float4(col,1);
    //  col.rg = gv;
}

float4 truchetLinesPatternSmoothEdgeEffect(float2 uv)
{
  float3 col(0);
  uv *= 10;
  
  float2 gv = fract(uv)-0.5;
  float2 id = floor(uv);
  
  float n = noise21(id);
  if (n < 0.5 ) {
    gv.x *= -1;
  }
  
  float threshold(0.48);
  if (gv.x > threshold || gv.y > threshold) col = float3(1,0,0);
  float width(0.05);
  float d = abs(abs(gv.x + gv.y) - 0.5)-width;
  float mask = smoothstep(0.01,-0.01, d);
  
    //  col += n;
  col += mask;
  return float4(col,1);
    //  col.rg = gv;
}


float4 truchetCircleSnakeEffect(float2 uv)
{
  uv *= 10;
  float3 col(0);
  float2 gv = fract(uv)-0.5;
  float2 id = floor(uv);
  
  float n = noise21(id);
  if (n < 0.5 ) {
    gv.x *= -1;
  }
  
  float threshold(0.48);
  if (gv.x > threshold || gv.y > threshold) col = float3(1,0,0);
  float width(0.1);
  float d = abs(abs(gv.x + gv.y) - 0.5)-width;
  
  d = length(gv - sign(gv.x + gv.y)*0.5)-0.5;
  float mask = smoothstep(0.01,-0.01, abs(d)-width);
  
    //  col += n;
  col += mask;
  return float4(col,1);
}

float4 truchetCircleSnakeAnimationEffect(float2 uv, float timer)
{
  float3 col(0);
  uv *= 10;
  float2 gv = fract(uv)-0.5;
  float2 id = floor(uv);
  
  float n = noise21(id);
  if (n < 0.5 ) {
    gv.x *= -1;
  }
  float t = timer*0.4;
  float threshold(0.48);
    //  if (gv.x > threshold || gv.y > threshold) col = float3(1,0,0);
  float width(0.1);
  float d = abs(abs(gv.x + gv.y) - 0.5)-width;
  float2 cUv = gv - sign(gv.x + gv.y)*0.5;
  d = length(cUv)-0.5;
  float mask = smoothstep(0.01,-0.01, abs(d)-width);
  float angle = atan(cUv.y/cUv.x);
  float checker = (fract((id.x + id.y)/2.0)*2)-0.6;
  float flow = sin(t + checker*angle*20);
  col += flow*mask;

  
  //  col += checker;
  return float4(col,1);
}

float4 truchetFinalwithTurchetUVCoordinates(float2 uv, float timer)
{
  float3 col(0);
  uv *= 10;
  float2 gv = fract(uv)-0.5;
  float2 id = floor(uv);
  
  float n = noise21(id);
  if (n < 0.5 ) {
    gv.x *= -1;
  }
  float t = timer*0.4;
  float threshold(0.48);
    //  if (gv.x > threshold || gv.y > threshold) col = float3(1,0,0);
  float width(0.2);
  float d = abs(abs(gv.x + gv.y) - 0.5)-width;
  float2 cUv = gv - sign(gv.x + gv.y)*0.5;
  d = length(cUv);
  float mask = smoothstep(0.01,-0.01, abs(d-0.5)-width);
  float angle = atan(cUv.y/cUv.x);
  float checker = (fract((id.x + id.y)/2.0)*2)-0.6;
    //  col += sin(t + checker*angle*20)*mask;
  float x = (angle/1.57);
  float y = ( d - (0.5-width))/(2*width);
  y = abs(y-0.5)*2;
  float2 tUv(x,y);
  col.rg += tUv*mask;
  
  
    //  col += checker;
  
  return float4(col,1);
}
