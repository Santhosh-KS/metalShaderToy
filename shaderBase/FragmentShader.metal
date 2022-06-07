//
//  FragmentShader.metal
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

float2 screenResolution(float x, float y)
{
  return float2(0.5*x, 0.5*y);
}


fragment float4 fragment_main(constant ScreenDimensions &screen [[buffer(11)]],
                              constant float &timer [[buffer(20)]],
                              VertexOut in [[stage_in]])
{
  
  float2 resolution = screenResolution(screen.width, screen.height);
  float2 uv = (in.position.xy-resolution)/ screen.width;
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
