//
//  SwiftUIView.swift
//  
//
//  Created by Taewon Yoon on 8/8/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainContainer<Content: View>: View {
    
    let contents: Content
    
    @State private var selectedTab = 0
    @State private var verticalOffset: CGFloat = 0
    private var tabs: [String] = []
    
    init(@ViewBuilder content: () -> Content, arr: [String]) {
        self.contents = content()
        self.tabs = arr
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Array(tabs.enumerated()), id: \.offset) { obj in
                    Button {
                        selectedTab = obj.offset
                        print(selectedTab)
                    } label: {
                        Text(obj.element)
                            .foregroundStyle(obj.offset == selectedTab ? Color.accentColor : Color.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            Divider()
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        contents
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .offset(x: -CGFloat(selectedTab) * geometry.size.width + verticalOffset)
                .animation(.easeInOut, value: selectedTab)
                .animation(.easeInOut, value: verticalOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            verticalOffset = value.translation.width
                        }
                        .onEnded { value in
                            let threshold = geometry.size.width / 2
                            if -value.predictedEndTranslation.width > threshold && selectedTab < tabs.count - 1 {
                                selectedTab += 1
                            } else if value.predictedEndTranslation.width > threshold && selectedTab > 0 {
                                selectedTab -= 1
                            }
                            verticalOffset = 0
                        }
                )
            }
        }
    }
}




@available(iOS 17.0, *)
#Preview {
    MainContainer(content: {
                Text("First View")
                Text("Second View")
                Text("Third View")
            }, arr: ["자산", "소비﹒수입", "연말정산"])
}

@available(iOS 17.0, *)
struct view: View {
    var body: some View {
        Text("hi")
    }
}
