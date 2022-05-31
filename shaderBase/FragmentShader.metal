//
//  FragmentShader.metal
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
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
  return fragment_cloud_animations(uv,timer);
}

