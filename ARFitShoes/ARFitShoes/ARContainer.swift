//
//  ARContainer.swift
//  ARFitShoes
//
//  Created by Jeongmin Ko on 2/13/24.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var shoeTracker: ShoeTracker
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        let configuration = ARBodyTrackingConfiguration()
        arView.session.run(configuration)
        arView.session.delegate = context.coordinator
        context.coordinator.arView = arView // ARView 참조를 Coordinator에 제공
        // 디버그 옵션 추가
        arView.debugOptions = [.showFeaturePoints, .showWorldOrigin, .showPhysics]
        
        // 신발 모델 추가
        addShoeModel(to: arView)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    // Coordinator 생성
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // 신발 모델 추가 메서드
    private func addShoeModel(to arView: ARView) {
        // 신발 모델 로드
        guard let shoeModel = try? ModelEntity.loadModel(named: "AirForce.usdz") else { return }
        shoeModel.scale = SIMD3<Float>(0.005, 0.005, 0.005) // 모델 크기 조정
        
        
        // 신발 모델을 추가할 앵커 생성
        let shoeAnchor = AnchorEntity() // 디폴트 위치에 추가
        shoeAnchor.name = "ShoeAnchor" // 신발 앵커의 이름 설정
        shoeAnchor.addChild(shoeModel)
        arView.scene.addAnchor(shoeAnchor)
    }
}

class Coordinator: NSObject, ARSessionDelegate {
    var parent: ARViewContainer
    var arView: ARView? // ARView 참조를 저장

    init(_ parent: ARViewContainer) {
        self.parent = parent
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let arView = self.arView else { return }
        
        for anchor in anchors {
            guard let bodyAnchor = anchor as? ARBodyAnchor else { continue }
            print("바디 인식됨 \(bodyAnchor.debugDescription)")
            DispatchQueue.main.async {
                self.updateShoeModel(on: arView, for: bodyAnchor)
            }
        }
    }

    func updateShoeModel(on arView: ARView, for bodyAnchor: ARBodyAnchor) {
        // 신발 앵커 가져오기
        guard let shoeAnchor = arView.scene.anchors.first(where: { $0.name == "ShoeAnchor" }) else { return }
        
        // 루트(보통 pelvis)의 전역 변환
        let rootTransform = bodyAnchor.transform
        
        // 왼쪽 발의 상대적 변환 가져오기
        if let leftFootTransform = bodyAnchor.skeleton.modelTransform(for: .leftFoot) {
            // 왼쪽 발의 전역 위치 계산
            let globalLeftFootTransform = simd_mul(rootTransform, leftFootTransform)
            
            let position = SIMD3<Float>(globalLeftFootTransform.columns.3.x,
                                        globalLeftFootTransform.columns.3.y,
                                        globalLeftFootTransform.columns.3.z)
            let rotation = simd_quatf(globalLeftFootTransform)
            
            // 신발 앵커의 위치와 회전 갱신
            shoeAnchor.position = position
            shoeAnchor.orientation = rotation
        }
    }

}
