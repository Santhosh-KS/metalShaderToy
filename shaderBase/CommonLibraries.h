//
//  CommonLibraries.h
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#ifndef CommonLibraries_h
#define CommonLibraries_h

float2 screenResolution(float x, float y);
float noise21(float2 uv);
float3 circle(float2 uv, float scale);
float smoothNoise(float2 uv, int m);

#endif /* CommonLibraries_h */
