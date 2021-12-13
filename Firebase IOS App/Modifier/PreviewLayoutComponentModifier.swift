//
//  PreviewLayoutComponentModifier.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 10/27/21.
//

import SwiftUI

struct PreviewLayoutComponentModifier: ViewModifier{
    let name: String
    func body(content: Content) -> some View{
        content
        .previewLayout(.sizeThatFits) .previewDisplayName(name) .padding()
    }
}
extension View{
    func preview(with name: String) -> some View{ self.modifier(PreviewLayoutComponentModifier(name: name))}
}


