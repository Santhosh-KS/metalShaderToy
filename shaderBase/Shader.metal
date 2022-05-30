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
