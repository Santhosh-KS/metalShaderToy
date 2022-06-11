//
//  FragmentShader.metal
//  shaderBase
//
//  Created by Santhosh K S on 31/05/22.
//

#include <metal_stdlib>
using namespace metal;

#import "Common.h"
#import "CommonLibraries.h"
#import "ShaderDefinitions.h"

#define MAX_STEP  100
#define MAX_DISTANCE  100.0
#define SURFACE_DISTANCE  0.1

float2 screenResolution(float x, float y)
{
  return float2(0.5*x, 0.5*y);
}


float getDist(float3 p) {
  float4 s(0,1.1,6,1);
  float sphereDistance = length(p - s.xyz) - s.w;
  float planeDistance = p.y;
//  return planeDistance;
//  return sphereDistance;
  return  min(sphereDistance, planeDistance);
}

float rayMarch(float3 rayOrigin, float3 rayDirection)
{
  float distanceToOrigin(0);

  for(int i = 0; i < MAX_STEP; i++) {
    float3 p = rayOrigin + rayDirection*distanceToOrigin;
    float distanceToScene =  getDist(p);
    distanceToOrigin += distanceToScene;
    if(distanceToOrigin > MAX_DISTANCE ||
       distanceToScene < SURFACE_DISTANCE) {
      break;
    }
  }
  return distanceToOrigin;
}

float3 getNormal(float3 p) {
  float d = getDist(p);
  float2 e(0.01,0);
  
  float3 n = d - float3(getDist(p-e.xyy),
                        getDist(p-e.yxy),
                        getDist(p-e.yyx));
  return  normalize(n);
}

float getLight(float3 p, float timer)
{
  float3 lightPos(0,5,6);
  float t = timer * 0.1;
  lightPos.xz += float2(sin(t), cos(t));
  float3 light = normalize(lightPos - p);
  float3 normal = getNormal(p);
  
  float diffuse = clamp(1.0,0.0,dot(normal, light));
//  float diffuse = dot(normal, light);
  float shadowDist = rayMarch(p+(normal*SURFACE_DISTANCE), light);
  
  if (shadowDist < length(lightPos-p)) { diffuse *= 0.01; }
  return diffuse;
}

float sdSphere(float2 point,
               float2 center,
               float  radius)
{
  return length(point - center) - radius;
}

float sdPlane(float2 point)
{
  return point.y;
}

//float sdBox( float3 p, float3 b )
//{
//  float3 d = abs(p) - b;
//  return min(max(d.x,max(d.y,d.z)),0.0) + length(max(d,0.0));
//}

float sdBox( float3 p, float3 b )
{
  float3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

fragment float4 fragment_main(constant ScreenDimensions &screen [[buffer(11)]],
                              constant float &timer [[buffer(20)]],
                              VertexOut in [[stage_in]])
{
  float2 resolution = screenResolution(screen.width, screen.height);
  float2 uv = (in.position.xy-resolution)/ screen.width;
  float3 col(0);
  
  uv.y = -uv.y;
  
  float3 rayOrigin(0,1,0);
  float3 rayDirection(normalize(float3(uv,1)));
  
  float distance = rayMarch(rayOrigin, rayDirection);
  float3  point = rayOrigin + rayDirection * distance;
  distance /= 6;
  float diffuseLight = getLight(point, timer);
//  col += distance;
  col = diffuseLight;
  
  

  return float4(col,1);
}
