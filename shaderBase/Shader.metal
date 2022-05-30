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

fragment float4 fragment_main(constant ScreenDimensions &params [[buffer(11)]],
                              VertexOut in [[stage_in]])
{
  float color = 1;
  in.position.x < params.width * 0.5 ? color = 0.7 : color = 0;
  return float4(color*0.2,color*0.3,color*0.4,1);
}
