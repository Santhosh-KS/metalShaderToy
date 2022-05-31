//
//  ShaderDefinitions.h
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#ifndef ShaderDefinitions_h
#define ShaderDefinitions_h

struct VertexIn {
  float4 position [[attribute(0)]];
};

struct VertexOut {
  float4 position [[position]];
};



#endif /* ShaderDefinitions_h */
