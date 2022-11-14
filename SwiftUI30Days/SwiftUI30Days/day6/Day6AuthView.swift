//
//  Day6LoginView.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 14/11/2022.
//

import SwiftUI
import Amplify

struct Day6LoginView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "person")
                TextField("username", text: $username)
                    .textInputAutocapitalization(.never)
                    .textContentType(.emailAddress)
            }
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(10))
            .padding(.horizontal)
            HStack {
                Image(systemName: "lock")
                SecureField("password", text: $password)
                    .textInputAutocapitalization(.never)
                    .textContentType(.password)
            }
            .padding()
            .background(Color.gray.opacity(0.3).cornerRadius(10))
            .padding(.horizontal)
            
            Button("Log In") {
                Task {
                    await self.authManager.signIn(username: username, password: password)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green.cornerRadius(10))
            .foregroundColor(Color.white)
            .fontWeight(.bold)
            .padding(.horizontal)
        }.task{ await authManager.getCurrentAuthUser() }
    }
}



struct Day6LogOutView : View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        Text("Sign Out")
    }
}

struct Day6SessionView : View {
    
    @EnvironmentObject var authManager: AuthManager
    var user: AuthUser
    
    var body: some View {
        VStack {
            Text("Session View \(user.username)")
            Button("Sign Out") {
                Task {
                    await self.authManager.signout()
                }
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(Color.green.cornerRadius(10))
            .foregroundColor(Color.white)
            .padding()
        }
    }
}

struct Day6ConfirmView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    
    var body: some View {
        Text("Confirm View")
    }
}

struct Day6SignUpView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    
    var body: some View {
        Text("Sign Up View")
    }
}


//struct AuthUser {
//    let username: String
//}

enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}

class AuthManager : ObservableObject {
    
    @Published var authState: AuthState = .login
    
    
    func getCurrentAuthUser() async {
        do {
            let user = try await Amplify.Auth.getCurrentUser()
            Task { @MainActor in
                
                self.authState = .session(user: user)
                
            }
        } catch {
            print("amplify ")
        }
    }
    
    
    func signIn(username: String, password: String) async {
        print("amplify login \(username) and \(password)")
        
        do {
            let signInResult = try await Amplify.Auth.signIn(username: username, password: password)
            
            if signInResult.isSignedIn {
                print("signed in successfully")
                await getCurrentAuthUser()
            }
            else {
                print("wrong pass")
            }
        } catch {
            print("amplify sign in error \(error)")
        }
    }
    
    func signout() async {
        let result = await Amplify.Auth.signOut()
        self.authState = .login
    }
    
}

struct Day6LoginView_Previews: PreviewProvider {
    
    @ObservedObject static var authManager = AuthManager()
    
    static var previews: some View {
        Day6LoginView()
            .environmentObject(authManager)
    }
}
