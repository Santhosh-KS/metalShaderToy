//
//  CommonLibraries.h
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#ifndef CommonLibraries_h
#define CommonLibraries_h

float2 screenResolution(float x, float y);

// Noise functions
float noise21(float2 uv); // pseudo random noise
float smoothNoise(float2 uv, int m); // psuedo random smooth noise

// Geometric shapes
float4 circle(float2 uv, float scale);

float4 grid(float2 uv);
float point(float2 uv, float2 p);
float Xor(float a, float b);

#endif /* CommonLibraries_h */
