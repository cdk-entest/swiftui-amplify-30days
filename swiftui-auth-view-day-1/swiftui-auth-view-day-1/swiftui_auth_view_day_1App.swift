//  swiftui_auth_view_day_1App.swift
//  swiftui-auth-view-day-1
//  Created by MINH HAI, TRAN on 14/10/2022.

import SwiftUI

@main
struct swiftui_auth_view_day_1App: App {
    
    @ObservedObject var authSessionManager =  AuthSessionManager()
    
    init(){
        self.authSessionManager.getCurrentAuthUser()
    }
   
    var body: some Scene {
        WindowGroup {
            switch self.authSessionManager.authState {
            case AuthState.login:
                LoginView()
                    .environmentObject(authSessionManager)
            case AuthState.signup:
                SignupView()
                    .environmentObject(authSessionManager)
            case AuthState.confirmCode(let username):
                ConfirmView(username: username)
                    .environmentObject(authSessionManager)
            case AuthState.session(let user):
                SessionView(user: user)
                    .environmentObject(authSessionManager)
            }
        }
    }
    
    private func configureAmplify(){
    }
}
