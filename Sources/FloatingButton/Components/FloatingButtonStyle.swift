//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import SwiftUI

struct FloatingButtonStyle: ButtonStyle {
    
    var cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .cornerRadius(cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.93 : 1.0)
            .animation(.easeIn(duration: 0.2), value: configuration.isPressed)
    }
}
