//
//  ContentView.swift
//  metalShaderToy
//
//  Created by Santhosh K S on 30/05/22.
//

import SwiftUI
import MetalKit

struct MetalView: View {
  @State private var metalView = MTKView()
  @State private var renderer: Renderer?
  
  var body: some View {
    VStack {
      MetalViewRepresentable(metalView: $metalView)
        .onAppear {
          renderer = Renderer(metalView: metalView)
        }
      Text("Metal Framgment Shader")
    }
    
  }
}


struct MetalViewRepresentable: NSViewRepresentable {
  @Binding var metalView: MTKView
  
  func makeNSView(context: Context) -> some NSView {
    metalView
  }
  func updateNSView(_ uiView: NSViewType, context: Context) {
    updateMetalView()
  }
  
  func updateMetalView() {
  }
}

struct MetalView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      MetalView()
      Text("Metal View")
    }
  }
}
