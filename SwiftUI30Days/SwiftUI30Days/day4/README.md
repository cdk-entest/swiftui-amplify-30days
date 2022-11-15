---
title: Shape and Path for Bubble Chat
description: build bubble chat using shape and path
author: haimtran
publishedDate: 11/13/2022
date: 2022-11-13
---

## Introduction

[Github](https://github.com/cdk-entest/swiftui-amplify-30days/blob/main/SwiftUI30Days/SwiftUI30Days/day4/README.md) this is day 4 and shows

- Shape and path
- Bubble chat
- ZStack

<img width="300" alt="Screen Shot 2022-11-15 at 15 49 21" src="https://user-images.githubusercontent.com/20411077/201876344-eff75198-c960-4704-8d62-0219c7474a1f.png">

## Shape and Path

create a shape and implement the path method, this will create a bubble chat shape

```swift
struct ChatButtle: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 15, height: 15)
        )
        return Path(path.cgPath)
    }
}
```

apply clipshape onto a text

```swift
Text("reading question here")
  .padding()
  .background(Color.gray.opacity(0.3))
  .clipShape(ChatButtle())
  .padding(.horizontal, 5)
```

also how to style a button

```swift
Button { self.showAnswer.toggle() } label: {
    Text(self.showAnswer ? "Hide Anwser" : "Show Answer")
    .fontWeight(.bold)
    .padding(.vertical)
    .foregroundColor(Color.white)
}
.frame(maxWidth: .infinity)
.background(Color.green)
.clipShape(RoundedRectangle(cornerRadius: 10))
.padding(.horizontal, 5)
```

## ZStack

put them together

```swift
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
                    Text("reading question here")
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .clipShape(ChatButtle())
                        .padding(.horizontal, 5)
                }
                if (self.showAnswer){
                    Text("reading answer here")
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
```
