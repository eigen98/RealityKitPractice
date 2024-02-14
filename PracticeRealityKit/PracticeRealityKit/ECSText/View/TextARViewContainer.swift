//
//  TextARViewContainer.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/13/24.
//

import SwiftUI
import RealityKit
//wiftUI에서 UIKit의 UIViewController를 사용할 수 있게 해주는 프로토콜
struct TextARViewContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return TextARViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
