//
//  SignoutView.swift
//  swiftui-auth-view-day-1
//
//  Created by MINH HAI, TRAN on 15/10/2022.
//

import SwiftUI

struct SignoutView: View {
    
    @EnvironmentObject var authSessionManager: AuthSessionManager
    
    var body: some View {
        Button(action: {
            self.authSessionManager.signOut()
        }, label: {
            Text("Sign Out")
                .foregroundColor(.white)
        })
        .frame(maxWidth: .infinity)
        .padding()
        .background(.purple)
        .cornerRadius(10)
        .padding()
    }
}

struct SignoutView_Previews: PreviewProvider {
    static let authSessionManager = AuthSessionManager()
    static var previews: some View {
        SignoutView()
            .environmentObject(authSessionManager)
    }
}
