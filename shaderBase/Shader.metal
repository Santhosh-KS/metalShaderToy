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


float noise21(float2 uv) {
  return  fract(sin(uv.x*500+ uv.y*20374)*123453);
}

fragment float4 fragment_main(constant ScreenDimensions &params [[buffer(11)]],
                              VertexOut in [[stage_in]]) {
  float2 ires(0.5*params.width,
              0.5*params.height);
  float2 uv = (in.position.xy-ires)/ params.width;
  float3 col = float3(0);
  float d = length(uv);
  col = float3(0.005/d);
  return float4(col,1);
}


