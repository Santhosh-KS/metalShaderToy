//
//  ShaderDefinitions.h
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#ifndef ShaderDefinitions_h
#define ShaderDefinitions_h

#import "CommonLibraries.h"

struct VertexIn {
  float4 position [[attribute(0)]];
};

struct VertexOut {
  float4 position [[position]];
};


float4 fragment_cloud_animations(float2 uv, float timer);

float3 mandleBrot(float2 uv);

#endif /* ShaderDefinitions_h */
