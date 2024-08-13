//
//  SwiftUIView 2.swift
//  
//
//  Created by Taewon Yoon on 8/13/24.
//

import SwiftUI

@available (iOS 17.0, *)
public struct CustomSheet<Content: View>: View {
    
    let contents: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.contents = content()
    }
    
    public var body: some View {
        contents
    }
}

@available (iOS 17.0, *)
#Preview {
    CustomSheet {
        Text("abc")
    }
}
