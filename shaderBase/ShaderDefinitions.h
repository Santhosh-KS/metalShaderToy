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
float4 mandleBrot(float2 uv);
float4 circleEffect(float2 uv, float timer);
float4 voronoiEffect(float2 uv, float timer);

// turchet Effects
float4 truchetLinesPatternLedEdgeEffect(float2 uv);
float4 truchetLinesPatternSmoothEdgeEffect(float2 uv);
float4 truchetCircleSnakeEffect(float2 uv);
float4 truchetCircleSnakeAnimationEffect(float2 uv, float timer);
float4 truchetFinalwithTurchetUVCoordinates(float2 uv, float timer);

#endif /* ShaderDefinitions_h */
