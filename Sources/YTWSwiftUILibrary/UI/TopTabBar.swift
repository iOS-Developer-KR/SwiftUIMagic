//
//  SwiftUIView.swift
//  
//
//  Created by Taewon Yoon on 8/8/24.
//

import SwiftUI


@available(iOS 17.0, *)
public class UnderLineComponent {
    var visible: Bool
    var color: Color
    var thickness: CGFloat
    
    init(visible: Bool = true, color: Color = Color.black, thickness: CGFloat = 1.0) {
        self.visible = visible
        self.color = color
        self.thickness = thickness
    }
}

@available(iOS 17.0, *)
public class TextComponent {
    var tabs: [String]
    var selectedColor: Color
    var unselectedColor: Color
    var isBold: Bool
    
    init(tabs: [String], selectedColor: Color = Color.black, unselectedColor: Color = Color.gray, isBold: Bool = true) {
        self.tabs = tabs
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.isBold = isBold
    }
}


@available(iOS 17.0, *)
public struct TopTabBar<Content: View>: View {
    
    let contents: Content
    let textComponent: TextComponent
    let underlineComponent: UnderLineComponent
    
    @State private var selectedTab = 0
    @State private var verticalOffset: CGFloat = 0
    
    public init(@ViewBuilder content: () -> Content, text: TextComponent, underline: UnderLineComponent) {
        self.contents = content()
        self.textComponent = TextComponent(tabs: ["자산", "소비﹒수입", "연말정산"], selectedColor: Color.red, unselectedColor: Color.gray, isBold: true)
        self.underlineComponent = UnderLineComponent(visible: true, color: Color.black, thickness: 1.0)
    }
    
    public var body: some View {
        VStack {
            HStack {
                ForEach(Array(textComponent.tabs.enumerated()), id: \.offset) { obj in
                    Button {
                        selectedTab = obj.offset
                        print(selectedTab)
                    } label: {
                        VStack {
                            Text(obj.element)
                                .bold(selectedTab == obj.offset)
                                .foregroundStyle(obj.offset == selectedTab ? textComponent.selectedColor : textComponent.unselectedColor)
                                .overlay {
                                    if underlineComponent.visible && selectedTab == obj.offset {
                                        underlineComponent.color
                                            .frame(width: UIScreen.main.bounds.width/3, height: underlineComponent.thickness)
                                            .offset(x: -(verticalOffset/3), y: 20)
                                    }
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            Divider()
            
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(0..<textComponent.tabs.count, id: \.self) { index in
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
                            if -value.predictedEndTranslation.width > threshold && selectedTab < textComponent.tabs.count - 1 {
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
    TopTabBar(content: {
        Text("First View")
        Text("Second View")
        Text("Third View")
    }, text: TextComponent(tabs: ["자산", "소비﹒수입", "연말정산"]), underline: UnderLineComponent())
//    TopTabBar(content: {
//                Text("First View")
//                Text("Second View")
//                Text("Third View")
//            }, 
//              arr: ["자산", "소비﹒수입", "연말정산"],
//              unselectColor: Color.gray,
//              selectColor: Color.red,
//              underline: UnderLineComponent()
//    )
}

@available(iOS 17.0, *)
struct view: View {
    var body: some View {
        Text("hi")
    }
}
