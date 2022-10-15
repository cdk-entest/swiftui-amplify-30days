//
//  SessionView.swift
//  swiftui-auth-view-day-1
//
//  Created by MINH HAI, TRAN on 15/10/2022.
//

import SwiftUI

struct SessionView: View {
    
    @EnvironmentObject var authSessionManager : AuthSessionManager
    let user: String
    
    var body: some View {
        VStack {
            Text("Welcome back \(self.user)!")
            Button(action: {
                self.authSessionManager.signOut()
            }, label: {
                Text("Sign Out")
                    .foregroundColor(.white)
            })
            .padding()
            .frame(maxWidth: .infinity)
            .background(.purple)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static let authSessionManager = AuthSessionManager()
    static var previews: some View {
        SessionView(user: "entest")
            .environmentObject(authSessionManager)
    }
}
