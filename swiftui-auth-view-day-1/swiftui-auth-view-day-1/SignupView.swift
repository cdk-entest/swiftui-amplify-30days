//  SignupView.swift
//  swiftui-auth-view-day-1
//  Created by MINH HAI, TRAN on 15/10/2022.

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var authSessionManager:  AuthSessionManager
    @State var username: String = ""
    @State var password: String = ""
    
    var usernameTextField: some View {
        TextField("username", text: $username)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.systemGray4))
            .padding()
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary))
            .padding(.horizontal, 15)
    }
    
    
    var passwordTextField: some View {
        TextField("password", text: $password)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.systemGray4))
            .padding()
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary))
            .padding(.horizontal, 15)
    }
    
    var signupButton: some View {
        Button(action: {
            self.authSessionManager.signUp(username: username, password: password)
        }, label: {
            Text("Sign Up")
                .foregroundColor(.white)
        })
        .padding()
        .frame(maxWidth: .infinity)
        .background(.purple)
        .cornerRadius(10)
        .padding()
    }
    
    var body: some View {
        VStack {
            Text("Create New Account")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer()
            usernameTextField
            passwordTextField
            signupButton
            Spacer()
        }
        .padding()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
