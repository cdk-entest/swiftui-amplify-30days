//
//  Day4DrawShape.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 10/11/2022.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ChatButtle: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 15, height: 15)
        )
        return Path(path.cgPath)
    }
}

struct Day4DrawShape: View {
    
    @State private var showAnswer: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Button {
                    self.showAnswer.toggle()
                } label: {
                    Text(self.showAnswer ? "Hide Anwser" : "Show Answer")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, 5)
            }.zIndex(2)
            ScrollView {
                VStack {
                    Text("Hello Hai, how are you doing today? A path is a series of drawing instructions such as “start here, draw a line to here, then add a circle there”, all using absolute coordinates. In contrast, a shape has no idea where it will be used or how big it will be used, but instead will be asked to draw itself inside a given rectangle.")
                    //            .frame(width: 300, height: 300)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(ChatButtle())
                        .padding(.horizontal, 5)
//                    Button {
//                        self.showAnswer.toggle()
//                    } label: {
//                        Text(self.showAnswer ? "Hide Anwser" : "Show Answer")
//                            .fontWeight(.bold)
//                            .padding(.vertical)
//                            .foregroundColor(Color.white)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .background(Color.purple)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.horizontal, 5)
                }
                if (self.showAnswer){
                    Text("The anwser is Hello Hai Hello Hai, how are you doing today? A path is a series of drawing instructions such as “start here, draw a line to here, then add a circle there”, all using absolute coordinates. In contrast, a shape has no idea where it will be used or how big it will be used, but instead will be asked to draw itself inside a given rectangle.")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.3))
                        .clipShape(ChatButtle())
                        .padding(.horizontal, 5)
                }
            }
            .zIndex(1)
        }
    }
}


