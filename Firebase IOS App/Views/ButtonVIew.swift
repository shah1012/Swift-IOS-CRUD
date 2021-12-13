//
//  ButtonVIew.swift
//  Firebase IOS App
//
//  Created by Dax C Shah on 10/28/21.
//

import SwiftUI

struct ButtonVIew: View {
    typealias ActionHandler = () -> Void
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    private let cornerRadius: CGFloat = 10
    
    internal init(title: String, background: Color = .blue, foreground: Color = .white, border: Color = .clear, handler: @escaping ButtonVIew.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler, label: {
            Text(title)
            .frame(maxWidth: .infinity, maxHeight: 50)
        })
            .background(background)
            .foregroundColor(foreground)
            .font(.system(size: 16, weight: .bold)) .cornerRadius(cornerRadius) .overlay(RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(border, lineWidth: 2)
            )
    }
}

struct ButtonVIew_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ButtonVIew(title: "Login") {} .preview(with: "LoginButton View")
            ButtonVIew(title: "A Different LogIn", background: .clear,
            foreground: .blue,
            border: .blue) {}
            .preview(with: "Another Button View")
        }
    }
}
