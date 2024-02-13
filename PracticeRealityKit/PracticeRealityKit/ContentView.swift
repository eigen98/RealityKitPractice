//
//  ContentView.swift
//  PracticeRealityKit
//
//  Created by Jeongmin Ko on 2/5/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination: TextARViewContainer(), label: {
                    Text("Text AR Example")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
