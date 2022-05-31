//
//  Renderer.swift
//  metalShaderToy
//
//  Created by Santhosh K S on 30/05/22.
//

import Foundation
import MetalKit


class Renderer: NSObject {
  var device: MTLDevice
  var commandQueue: MTLCommandQueue
  var library: MTLLibrary
  var pipelineState: MTLRenderPipelineState
  var timer: Float = 0
  
  var screenDimension = ScreenDimensions()
  
  init(metalView: MTKView) {
    
    device = honestValue(MTLCreateSystemDefaultDevice())
    commandQueue = honestValue(device.makeCommandQueue())
    metalView.device = device
    
      // create the shader function library
    library = honestValue(device.makeDefaultLibrary())
    
      // create the pipeline state object
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertex_main")
    pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragment_main")
    pipelineDescriptor.colorAttachments[0].pixelFormat =
    metalView.colorPixelFormat
    pipelineDescriptor.vertexDescriptor = QuadVertex().descriptor
    
    pipelineState = honestValue(try! device.makeRenderPipelineState(descriptor: pipelineDescriptor))
    super.init()
    metalView.delegate = self
  }
}

extension Renderer {
  var quad: Quad {
    Quad(device: device)
  }
}

extension Renderer: MTKViewDelegate {
  func mtkView(
    _ view: MTKView,
    drawableSizeWillChange size: CGSize
  ) {
    screenDimension.width = UInt32(size.width)
    screenDimension.height = UInt32(size.height)
  }
  
  func draw(in view: MTKView) {
    guard
      let commandBuffer = commandQueue.makeCommandBuffer(),
      let descriptor = view.currentRenderPassDescriptor,
      let renderEncoder =
        commandBuffer.makeRenderCommandEncoder(
          descriptor: descriptor) else {
      return
    }
    renderEncoder.setRenderPipelineState(pipelineState)
    renderEncoder.setVertexBuffer(quad.vertexBuffer, offset: 0, index: 0)
    
    renderEncoder.setFragmentBytes(
      &screenDimension,
      length: MemoryLayout<ScreenDimensions>.stride,
      index: 11)
    
//    var timer: Float = 0
//
//      // 1
//    timer += 10.1
//    var currentTime = sin(timer)
    timer += 0.1
    var currentTime = timer
      // 2
    renderEncoder.setFragmentBytes(
      &currentTime,
      length: MemoryLayout<Float>.stride,
      index: 20)

    renderEncoder.drawIndexedPrimitives(type: .triangle,
                                        indexCount: quad.indices.count,
                                        indexType: .uint16,
                                        indexBuffer: quad.indexBuffer,
                                        indexBufferOffset: 0)
    
    renderEncoder.endEncoding()
    commandBuffer.present(honestValue(view.currentDrawable))
    commandBuffer.commit()
  }
}
