//
//  ContentView.swift
//  ARFitShoes
//
//  Created by Jeongmin Ko on 2/13/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var shoeTracker = ShoeTracker()
    var body: some View {
        ARViewContainer()
            .environmentObject(shoeTracker)
        ZStack {
            
            // 조건을 여기서 직접 사용
            if !shoeTracker.isShoeVisible {
                DirectionIndicator()
                    .environmentObject(shoeTracker) // 환경 객체를 전달
            }
        }
    }
}

#Preview {
    ContentView()
}
class ShoeTracker: ObservableObject {
    @Published var shoePosition: SIMD3<Float>?
    @Published var isShoeVisible: Bool = true
}
struct DirectionIndicator: View {
    @EnvironmentObject var shoeTracker: ShoeTracker

    var body: some View {
        // 화살표를 신발의 방향으로 회전시키는 로직 구현
        // 예시 코드는 실제 방향 계산 로직을 포함하지 않음
        Text("→").font(.largeTitle)
    }
}
