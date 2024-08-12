//
//  SwiftUIView.swift
//  
//
//  Created by Taewon Yoon on 8/12/24.
//

import SwiftUI

@available(iOS 17.0, *)
struct SwiftUIView: View {
    var cal = Calendar(identifier: .japanese)

    var body: some View {
        Button {
            let calendar = Calendar.current
            let monthInterval = calendar.dateInterval(of: .month, for: Date())!
            print(monthInterval.start.addingTimeInterval(86400))
        } label: {
            Text("Hello, World!")
        }
        
    }
}

@available(iOS 17.0, *)
#Preview {
    SwiftUIView()
}
