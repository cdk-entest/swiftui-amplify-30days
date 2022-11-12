//
//  SwiftUI30DaysApp.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 08/11/2022.
//

import SwiftUI
import Combine
import Amplify
import AWSAPIPlugin
import AWSCognitoAuthPlugin
import AWSDataStorePlugin

@main
struct SwiftUI30DaysApp: App {
    
    @ObservedObject var sot = Day5SourceOfTruth()
    
    init(){
       configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            Day5ChatAppView(sot: sot)
        }
    }
    
    func configureAmplify(){
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            print("Amplify configured successuflly")
        } catch {
            print("Amplify configure error \(error)")
        }
    }
}
