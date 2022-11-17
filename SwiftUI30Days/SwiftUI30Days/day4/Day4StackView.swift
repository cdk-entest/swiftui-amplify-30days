//  Day4StackView.swift
//  SwiftUI30Days
//  Created by MINH HAI, TRAN on 10/11/2022.

import SwiftUI

struct Day4StackView: View {
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "gift")
                .font(.title)
            VStack(alignment: .leading) {
                Text("Title")
                    .font(.title)
                Text(.now, format: Date.FormatStyle().day(.defaultDigits).month(.wide))
                Text("Location")
            }
        }
        .padding()
        .padding(.top, 15.0)
        .background{
            ZStack(alignment: .top) {
                Rectangle()
                    .opacity(0.3)
                Rectangle()
                    .frame(maxHeight: 15.0)
            }
            .foregroundColor(.teal)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
    }
}
