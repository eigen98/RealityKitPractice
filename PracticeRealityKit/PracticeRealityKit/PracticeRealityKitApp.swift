//
//  PracticeRealityKitApp.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/5/24.
//

import SwiftUI

//SwiftUI 앱에서는 UIApplicationDelegate 대신 App 프로토콜을 구현하여 앱의 생명주기 이벤트를 관리
@main
struct PracticeRealityKitApp: App {
    // AppDelegate를 SwiftUI 앱에 연결
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 여기에서 System 등록
        ChangeMeshAndColorSystem.registerSystem()
        return true
    }
}
