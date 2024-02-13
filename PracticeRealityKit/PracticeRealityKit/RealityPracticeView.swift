//
//  RealityPracticeView.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/5/24.
//

import SwiftUI
import RealityKit
import ARKit


struct RealityPracticeView: View {
    var body: some View {
        VStack{
            RealityKitView()
        }
//        RealityView()
    }
}


// Wrap ARView for SwiftUI
struct RealityKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        return ARView(frame: .zero)
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

// SwiftUI Preview
struct RealityPracticeView_Preview: PreviewProvider {
    static var previews: some View {
        RealityPracticeView()
    }
}
