//
//  MyScene.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 10/11/2022.
//  Create myown scene

import SwiftUI

struct MyScene: Scene {
    var body: some Scene {
        WindowGroup {
            TabView {
                Day4TabView()
                    .tabItem {
                        Label("Journal", systemImage: "book")
                    }
                Day4SettingView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}


