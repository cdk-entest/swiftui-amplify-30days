//
//  Day4LayerView.swift
//  SwiftUI30Days
//
//  Created by MINH HAI, TRAN on 10/11/2022.
//

import SwiftUI

struct Day4LayerView: View {
    
    let landscapeName = "Flowers_20_Yellow_Daisy"
    let landscapeCaption = "This photo is wider than it is tall"
    let portraitName = "Flowers_20_Yellow_Daisy"
    let portraitCaption = "This photo is taller than it is wide"
    
    var body: some View {
        CaptionedPhoto(assetName: portraitName, captionText: portraitCaption)
    }
}

struct CaptionedPhoto: View {
    
    let assetName: String
    let captionText: String
    
    var body: some View {
        Image(assetName)
            .resizable()
            .scaledToFit()
            .overlay(alignment: .bottom) {
                    Caption(text: captionText)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding()
    }
}

struct Caption: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding()
            .background(.purple.opacity(0.75), in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding()
    }
}
