//
//  SignUpView.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 17/11/2022.
//

import SwiftUI

struct FoodSignUpView: View {
    
    private enum FocusElement {
        case username
        case password
    }
    
    private enum SignUpType {
        case passkey
        case password
    }
    
    private var isFormValid: Bool {
        if usePassKey {
            return !username.isEmpty
        } else {
            return !username.isEmpty && !password.isEmpty
        }
    }
    
    @FocusState private var focusedElement: FocusElement?
    @State private var username = ""
    @State private var password = ""
    @State private var usePassKey : Bool = true
    
    var body: some View {
        Form {
            Section {
                LabeledContent("User name") {
                    TextField("User name", text: $username)
                        .textContentType(.username)
                        .multilineTextAlignment(.trailing)
                }
                
                if !usePassKey {
                    LabeledContent("Password") {
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .multilineTextAlignment(.trailing)
                            .focused($focusedElement, equals: .password)
                            .labelsHidden()
                    }
                }
                
                LabeledContent("User Passkey"){
                    Toggle("Use Passkey", isOn: $usePassKey)
                        .labelsHidden()
                }
                
            } header: {
                Text("Create an account")
            } footer: {
                Label("""
                    When you sign up with a passkey, all you need is a user name. \
                    The passkey will be available on all of your devices.
                    """, systemImage: "person.badge.key.fill")
            }
        }
        .formStyle(.grouped)
        .animation(.default, value: usePassKey)
        .frame(maxWidth: 500)
        .navigationTitle("Sign Up")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Sign Up") {
                }
                .disabled(!isFormValid)
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    
                }
            }
        }
        .onAppear {focusedElement = .username}
    }
}

struct SignUpView_Previews: PreviewProvider {
    
    struct Preview: View {
        var body: some View {
            FoodSignUpView()
        }
    }
    
    static var previews: some View {
        NavigationStack {
            Preview()
        }
    }
}
