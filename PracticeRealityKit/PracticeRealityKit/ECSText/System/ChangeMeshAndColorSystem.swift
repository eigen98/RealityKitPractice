//
//  ChangeMeshAndColorSystem.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/13/24.
//

import Foundation
import SwiftUI
import RealityKit

@available(iOS 15.0, *)
class ChangeMeshAndColorSystem: System {
    // ModelComponent와 PhysicsBodyComponent를 모두 가진 엔티티를 찾는 쿼리 정의
    static let query = EntityQuery(where: .has(ModelComponent.self) && .has(PhysicsBodyComponent.self))
    
    // 시스템 초기화 시 호출되는 생성자. 시스템 활성화 로그 출력
    required init(scene: RealityKit.Scene) {
        print("RealityKit System Activate")
    }

    // 매 프레임마다 호출되어 엔티티 상태를 업데이트하는 메서드
    func update(context: SceneUpdateContext) {
        context.scene.performQuery(Self.query).forEach { entity in
            // 엔티티가 ModelEntity 타입인지 확인, 아니면 반복 건너뛰기
            guard let entity = entity as? ModelEntity else { return }
            // 엔티티의 메시를 반지름이 0.1인 구로 변경
            entity.model?.mesh = .generateSphere(radius: 0.1)
            // 새로운 물리 기반 Material 생성, 기본 색상을 오렌지색으로 설정
            var material = PhysicallyBasedMaterial()
            material.baseColor.tint = .systemOrange
            // 엔티티의 재질을 새로운 오렌지색 재질로 변경
            entity.model?.materials = [material]
        }
    }
}
