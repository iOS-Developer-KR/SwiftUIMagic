//
//  SwiftUIView.swift
//  
//
//  Created by Taewon Yoon on 8/12/24.
//

import SwiftUI

@available(iOS 17.0, *)
@Observable
class ViewState {
    var stack = NavigationPath()
    var topTabBarExist = true
}

@available(iOS 17.0, *)
struct SwiftUIView: View {
    @Environment(ViewState.self) var viewState
    
    var cal = Calendar(identifier: .japanese)

    var body: some View {
        @Bindable var bindableViewState = viewState
        TopTabBar(content: {
            Text("First View")
            SwiftUIView2()
            Text("Third View")
        }, text: TextComponent(tabs: ["자산", "소비﹒수입", "연말정산"]), underline: UnderLineComponent(), visible: $bindableViewState.topTabBarExist)
        
    }
}

@available(iOS 17.0, *)
struct SwiftUIView2: View {
    @State private var tmp = false
    @Environment(ViewState.self) var viewState
    
    var cal = Calendar(identifier: .japanese)

    var body: some View {
        NavigationStack {
            Text("에혀;;")
                .navigationDestination(isPresented: $tmp) {
                    SwiftUIView3()
                }
            Button {
                tmp.toggle()
            } label: {
                Text("에혀")
            }
            NavigationLink {
                Button {
                    viewState.topTabBarExist.toggle()
                } label: {
                    Text("에혀")
                }
            } label: {
                Text("뷰이동")
            }

        }
        
    }
}

@available(iOS 17.0, *)
struct SwiftUIView3: View {
    @Environment(ViewState.self) var viewState

    var body: some View {
        Text("abc")
        Button {
            viewState.topTabBarExist.toggle()
        } label: {
            Text("에혀")
        }
    }
}



@available(iOS 17.0, *)
#Preview {
    SwiftUIView()
        .environment(ViewState())
}
