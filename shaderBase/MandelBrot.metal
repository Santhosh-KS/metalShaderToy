//
//  MandelBrot.metal
//  shaderBase
//
//  Created by Santhosh K S on 07/06/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

float3 mandleBrot(float2 uv)
{
  float2 m(0.000001,0.000001);
  float zoom = pow(10, -m.x*3);
  float maxIter = 100;
  float2 z(0);
  float2 c = uv*zoom*3;
  c += float2(-0.39955, 0.07999);
  float itr(0);
  for (float i = 0; i < maxIter; i++) {
    z = float2((z.x * z.x) - (z.y * z.y), 2*z.x*z.y) + c;
    if (length(z) > 2) { break; }
    itr++;
  }
  float f = itr/maxIter;
  float3 col(f);
  return  col;
}
