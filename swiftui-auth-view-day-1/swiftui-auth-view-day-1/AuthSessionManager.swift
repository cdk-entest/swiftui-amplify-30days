//
//  AuthSessionManager.swift
//  swiftui-auth-view-day-1
//
//  Created by MINH HAI, TRAN on 15/10/2022.
//

import Foundation

enum AuthState {
    case signup
    case login
    case confirmCode(username: String)
    case session(user: String)
}

final class AuthSessionManager : ObservableObject {
    @Published var authState: AuthState = AuthState.login
    
    func showSignup(){
        print("show sign up form")
        self.authState = AuthState.signup
    }
    
    func showLogin(){
        print("show login form")
        self.authState = AuthState.login
    }
    
    func getCurrentAuthUser(){
        print("get current auth user")
    }
    
    func signUp(username: String, password: String){
        print("signup \(username) and \(password)")
        self.authState = AuthState.session(user: "entest")
    }
    
    func signOut(){
        print("signout user ")
        self.authState = AuthState.login
    }
    
    func confirm(username: String, code: String){
        print("confirm \(username) and code \(code)")
        self.authState = AuthState.session(user: "entest")
    }
    
    func login(username: String, password: String){
        print("login \(username) and \(password)")
        // amplify login
        self.authState = AuthState.session(user: "entest")
    }
}
