//  ConfirmView.swift
//  swiftui-auth-view-day-1
//  Created by MINH HAI, TRAN on 15/10/2022.

import SwiftUI

struct ConfirmView: View {
    
    @EnvironmentObject var authSessionManager: AuthSessionManager
    @State var confirmCode: String = ""
    let username: String
    
    var body: some View {
        VStack {
            
        TextField("confirm code", text: $confirmCode)
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(Color(.systemGray4))
            .padding()
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.primary))
            .padding(.horizontal, 15)
            
            Button(action: {
                self.authSessionManager.confirm(username: username, code: confirmCode)
            }, label: {
                Text("Confirm")
                    .foregroundColor(.white)
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(.purple)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(username: "entest")
    }
}
