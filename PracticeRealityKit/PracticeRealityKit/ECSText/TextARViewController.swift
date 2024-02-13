//
//  TextARViewController.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/13/24.
//

import Foundation
import SwiftUI
import RealityKit

class TextARViewController: UIViewController {
    var arView = ARView(frame: .zero) //AR 콘텐츠를 렌더링하고 사용자와 상호작용하는 데 사용
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.backgroundColor = .black
        for index in -2...2 {
            //3D 텍스트를 생성
            //텍스트 문자열로부터 3D 텍스트 메시를 생성
            //extrusionDepth: 텍스트의 깊이(두께)를 결정
            //containerFrame: 텍스트를 담을 컨테이너의 크기를 정의
            let text = MeshResource.generateText("\(index + 3)",
                          extrusionDepth: 0.01,
                                    font: .systemFont(ofSize: 0.15),
                          containerFrame: .zero,
                               alignment: .center,
                           lineBreakMode: .byCharWrapping)
            
            //생성된 텍스트 메시와 비발광 Material을 사용하여 모델 엔티티를 생성합니다.
            let entity = ModelEntity(mesh: text, materials: [UnlitMaterial()]) // 3D 모델을 나타내는 ModelEntity의 인스턴스를 저장
            entity.position.x = Float(index) * 0.75
            let anchor = AnchorEntity() //AR 씬에 엔티티를 배치하기 위한 앵커 엔티티를 생성
            entity.setParent(anchor) //생성된 엔티티를 앞서 생성한 앵커 엔티티의 자식으로 설정합니다. 이를 통해 엔티티가 AR 씬에 올바르게 배치됩니다.
            entity.name = "Prim\(index + 3)"
            if entity.name == "Prim2" || entity.name == "Prim4" {
                entity.components[PhysicsBodyComponent.self] = .init()
            }
            
            arView.scene.addAnchor(anchor)
        }
        
        self.view.addSubview(arView)
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: self.view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
