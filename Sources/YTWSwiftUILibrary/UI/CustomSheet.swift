//
//  SwiftUIView 2.swift
//  
//
//  Created by Taewon Yoon on 8/13/24.
//

import SwiftUI

@available (iOS 17.0, *)
public struct CustomSheet<Content: View>: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var showNewScreen: Bool
    
    let contents: Content
    
    public init(@ViewBuilder content: () -> Content, isPressed: Binding<Bool>) {
        self.contents = content()
        _showNewScreen = isPressed
    }
    
    public var body: some View {
        contents
    }
}

@available (iOS 17.0, *)
#Preview {
    CustomSheet(content: {
        Text("abc")
    }, isPressed: .constant(false))
}
