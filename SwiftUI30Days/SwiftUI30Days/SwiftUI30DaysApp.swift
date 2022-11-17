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

// day 6 auth
//@main
//struct SwiftUI30DaysApp: App {
//    @ObservedObject var authManager = AuthManager()
//
//    init() {
//        configureAmplify()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//
//            switch authManager.authState {
//            case .login:
//                Day6LoginView()
//                    .environmentObject(authManager)
//            case .signUp:
//                Day6SignUpView()
//                    .environmentObject(authManager)
//            case .session(let user):
//                Day6SessionView(user: user)
//                    .environmentObject(authManager)
//            case .confirmCode(username: let username):
//                Day6ConfirmView()
//                    .environmentObject(authManager)
//            }
//        }
//    }
//
//    func configureAmplify() {
//        do {
//            try Amplify.add(plugin: AWSCognitoAuthPlugin())
//            try Amplify.configure()
//            print("Amplify configured with auth plugin")
//        } catch {
//            print("Amplify configure error \(error)")
//        }
//    }
//}

// day 5 chat app
//@main
//struct SwiftUI30DaysApp: App {
//
//    @ObservedObject var sot = Day5SourceOfTruth()
//
//    init(){
//       configureAmplify()
//    }
//
//    var body: some Scene {
//        WindowGroup {
//            Day5ChatAppView(sot: sot)
//        }
//    }
//
//    func configureAmplify(){
//        do {
//            try Amplify.add(plugin: AWSCognitoAuthPlugin())
//            try Amplify.add(plugin: AWSAPIPlugin())
//            try Amplify.add(plugin: AWSDataStorePlugin(modelRegistration: AmplifyModels()))
//            try Amplify.configure()
//            print("Amplify configured successuflly")
//        } catch {
//            print("Amplify configure error \(error)")
//        }
//    }
//}

// day 3 network request and opensearch example
//@main
//struct SwiftUI30DayApp: App {
//
//    var body: some Scene {
//        WindowGroup{
//            OpenSearchView()
//        }
//    }
//}


// day 4 shape and path and chat bubble
//@main
//struct SwiftUI30DayApp: App {
//    var body: some Scene {
//        WindowGroup {
//           Day4DrawShape()
//        }
//    }
//}


// food
@main
struct FoodApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FoodSignUpView()
            }
        }
    }
}

