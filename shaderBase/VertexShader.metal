//
//  Shader.metal
//  metalShaderToy
//
//  Created by Santhosh K S on 30/05/22.
//

#include <metal_stdlib>
#include "Common.h"
using namespace metal;

#import "ShaderDefinitions.h"


vertex VertexOut vertex_main(const VertexIn vertexIn [[stage_in]]) {
  return VertexOut{vertexIn.position};
}



