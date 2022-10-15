//  ContentView.swift
//  swiftui-auth-view-day-1
//  Created by MINH HAI, TRAN on 14/10/2022.

import SwiftUI

struct LoginTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.systemGray4))
            .padding()
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary))
            .padding(.horizontal, 15)
    }
}


struct LoginView: View {

    @EnvironmentObject var authSessionManager: AuthSessionManager
    @State var username: String = ""
    @State var password: String = ""
    
    var usernameTextField: some View {
        TextField("username", text: $username)
            .textFieldStyle(LoginTextFieldStyle())
    }
    
    var passwordTextField: some View {
        TextField("password", text: $password)
            .textFieldStyle(LoginTextFieldStyle())
    }
    
    var loginButton: some View {
        Button(action: {
            let _ = print("click login button")
            self.authSessionManager.login(username: username, password: password)
        }, label: {
            Text("Login")
                .foregroundColor(.white)
        })
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.purple)
        .cornerRadius(10)
        .padding()
    }
    
    var signupButton: some View {
        Button(action: {
            self.authSessionManager.authState = AuthState.signup
        }, label: {
           Text("Don't have an account yet, sign up")
        })
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome back!")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Log in with your account")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer()
                .frame(height: 50)
            usernameTextField
            passwordTextField
            loginButton
            Spacer()
            signupButton
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static let authSessionManager = AuthSessionManager()
    static var previews: some View {
        LoginView()
            .environmentObject(authSessionManager)
    }
}
