//  Day4Binding.swift
//  SwiftUI30Days
//  Created by MINH HAI, TRAN on 10/11/2022.
//  Play with TextField

import SwiftUI

struct PlayButton: View {
    @Binding var isPlaying: Bool
    @State var username = ""
    
    var body: some View {
        VStack {
            TextField("username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.3).cornerRadius(10))
                .textContentType(.emailAddress)
                .padding()
            
            TextField("username", text: $username)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .stroke(Color.purple, lineWidth: 2)
                }
                .padding()
            
            TextField("usernmae", text: $username)
                .padding(.vertical, 8)
                .background(
                    VStack {
                        Spacer()
                        Color.gray.frame(height: 2)
                    }
                )
                .padding()
            
            HStack {
                Image(systemName: "person")
                TextField("username", text: $username)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.purple, lineWidth: 2)
            }
            .padding()
            
            
            TextField("username", text: $username)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .padding()
            //                .background(Color.gray.opacity(0.3).cornerRadius(10))
                .background(RoundedRectangle(cornerRadius: 8).stroke(self.username != "" ? Color.red : Color.purple, lineWidth: 2))
                .padding()
            Button(isPlaying ? "Paused" : "Play") {
                isPlaying.toggle()
            }
        }
    }
}



struct Day4BindingView: View {
    
    @State private var isPlaying : Bool = false
    
    var body: some View {
        PlayButton(isPlaying: $isPlaying)
    }
}



struct Day4LoginView : View {
    
    @State var username = ""
    @State var password = ""
    @FocusState private var usernameFocus: Bool
    
    var body: some View {
        Form {
            LabeledContent("User name") {
                TextField("User name", text: $username)
                    .textContentType(.username)
                    .multilineTextAlignment(.leading)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($usernameFocus)
                    .foregroundColor(usernameFocus ? Color.red : Color.purple)
                    .labelsHidden()
                }
            LabeledContent("Password") {
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .multilineTextAlignment(.leading)
                    .labelsHidden()
            }
        }
    }
}

struct Day4_Previews: PreviewProvider {
    
    @State static var isPlaying: Bool = false
    
    static var previews: some View {
        PlayButton(isPlaying: $isPlaying)
    }
}
