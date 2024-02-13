//
//  BodyTrakingARView.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/7/24.
//

import Foundation
import RealityKit
import ARKit

class BodyTrackingARView: ARView {
    var bodyTrackingComponent: BodyTrackingComponent?
    
    func setupBodyTracking() {
        // AR 세션 구성
        // BodyTrackingComponent 초기화 및 설정
        var bodyTrackingComponent = BodyTrackingComponent()
        self.bodyTrackingComponent = bodyTrackingComponent
        
        // 특정 타겟 설정 (예: 첫 번째 검출된 사람)
//        bodyTrackingComponent.target = .firstDetectedPerson
        
        bodyTrackingComponent.target = .body(identifier: .init())
        // 바디 트래킹 컴포넌트를 사용하여 엔티티 생성 및 추가
//        let entity = ModelEntity(mesh: .generateHumanBaseMesh())
//        let entity = ModelEntity(mesh: .generateSphere(radius: 30))
//        entity.components.set(bodyTrackingComponent)
//        self.scene.addAnchor(entity)
    }
    
    func pauseBodyTracking() {
        // 바디 트래킹 일시 중지
        bodyTrackingComponent?.isPaused = true
    }
    
    func resumeBodyTracking() {
        // 바디 트래킹 재개
        bodyTrackingComponent?.isPaused = false
    }
}

// RealityKit의 ModelEntity나 MeshResource에는 generateHumanBaseMesh()와 같은 메서드가 실제로 존재하지 않습니다.
// 이는 적절한 사람 모델을 로드하는 방법을 가정한 것입니다.
// 실제로 사용자의 모델을 로드하려면, 호환되는 rigged 모델을 USDZ 형식으로 준비하고, Entity.loadModelAsync()와 같은 메서드를 사용하여 로드해야 합니다.
