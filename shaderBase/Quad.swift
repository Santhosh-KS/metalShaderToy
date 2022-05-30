//
//  Quad.swift
//  metalShaderToy
//
//  Created by Santhosh K S on 30/05/22.
//

import Foundation
import MetalKit

public struct Quad {
  let vertices: [Float]
  let indices: [UInt16]
  let vertexBuffer: MTLBuffer
  let indexBuffer: MTLBuffer
}

fileprivate let _vertices:[Float] = [-1,  1,  0,
                                      1,  1,  0,
                                      -1, -1,  0,
                                      1, -1,  0]

fileprivate let _indices:[UInt16] = [ 0, 3, 2,
                                      0, 1, 3]

public extension Quad {
  init(device:MTLDevice, scale:Float=1.0) {
    vertices = _vertices.map { $0 * scale}
    indices = _indices
    vertexBuffer = honestValue(device.makeBuffer(bytes: &vertices,
                                                 length: MemoryLayout<Float>.stride * vertices.count))
    indexBuffer = honestValue(device.makeBuffer(bytes: &indices,
                                                length: MemoryLayout<Float>.stride * indices.count))
  }
}

fileprivate func getVertexDescriptor() -> MTLVertexDescriptor {
  let vertexDescriptor = MTLVertexDescriptor()
  vertexDescriptor.attributes[0].offset = 0
  vertexDescriptor.attributes[0].bufferIndex = 0
  vertexDescriptor.attributes[0].format = .float3
  vertexDescriptor.layouts[0].stride = MemoryLayout<Float>.stride * 3
  
  return vertexDescriptor
}

struct QuadVertex {
  let descriptor: MTLVertexDescriptor = getVertexDescriptor()
}
