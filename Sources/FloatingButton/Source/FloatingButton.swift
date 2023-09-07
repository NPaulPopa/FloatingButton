//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import SwiftUI
import Themes
import Combine

public struct FloatingButton: View {
    
    @State private var buttonHeight: CGFloat?
    @State private var showPencil: Bool?
    
    var translationPublisher: PassthroughSubject<CGFloat, Never>
    private var cancellables = Set<AnyCancellable>()
        
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    public init(translation:  PassthroughSubject<CGFloat, Never>) {
        self.translationPublisher = translation
    }
    
    var capsuleWidth: CGFloat { (screenWidth * 0.2765).rounded(toPlaces: 1)}
    var capsuleHeight: CGFloat { (capsuleWidth * 0.428).rounded(toPlaces: 1)}
    
    var circleWidth: CGFloat { (screenWidth * 0.11865).rounded(toPlaces: 1) }
    var circleHeight: CGFloat { circleWidth }
   
    var pencilWidth: CGFloat { (capsuleWidth * 0.1436).rounded(toPlaces: 1) }
    var pencilHeight: CGFloat { pencilWidth.rounded(toPlaces: 1) }

    public var body: some View {
        
        Button { additemsFloatingButtonTapped() } label: {

            HStack(alignment: .center,spacing: 6.7) {
                Image("newListPencil",bundle: .themes)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: pencilWidth, height: pencilHeight, alignment: .center)

                   if !(showPencil ?? false) {

                           Text("New List")
                           .foregroundColor((showPencil ?? false) ? .red : .white)
                               .font(Font.custom("Futura", size: 16))
                               .minimumScaleFactor(0.8)
                               .animation(.easeOut, value: showPencil)
                    }
                }
                .padding()
                .frame(width: setWidth(), height: setHeight(), alignment: .center)
                .animation(.easeInOut, value: buttonHeight)
                .background(Color.blue)
        }
        .onReceive(translationPublisher, perform: { newValue in
            
            withAnimation(.linear(duration: 0.33)) {
                self.buttonHeight = newValue
                _ = showPencilOnly(newValue: newValue)
            }
        })
        .buttonStyle(FloatingButtonStyle(cornerRadius: (buttonHeight ?? 0) > 40 ? (buttonHeight ?? 0) / 2 : 40))
        .clipped()
        
    }
    
    private func additemsFloatingButtonTapped() {
        NotificationCenter.default.post(name: .addItemsFloatingButtonTapped, object: nil)
    }
}

//MARK: - Pencil Dimensions

extension FloatingButton {
    
    func showPencilOnly(newValue: CGFloat ) -> Bool {
        
        let lowerThreshold = -16.0 // 0.0
        
        if let _ = showPencil, let _ = self.buttonHeight {
            
            if newValue <= lowerThreshold {
                showPencil = false
                return false // show both when dragging down
                
            } else {
                showPencil = true
                return true
            }
            
        } else { // initial case when is nil, we show both pencil and text
            showPencil = false
            return false
        }
    }
}

//MARK: - Capsule Dimensions

extension FloatingButton {
    
    private func setHeight() -> CGFloat {
        
        let lowerThreshold = -16.0 // 0.0
        
        if let buttonHeight = buttonHeight {
            
            if buttonHeight <= lowerThreshold {
                return capsuleHeight
            } else {
                return circleHeight
            }
            
        } else { // initial case when is nil
            return capsuleHeight
        }
    }
    
    private func setWidth() -> CGFloat {
        
        let lowerThreshold = -16.0 //0.0
        
        if let buttonHeight = buttonHeight {
            
            if buttonHeight <= lowerThreshold {
                
                return capsuleWidth
                
            } else {
                return circleWidth
            }
            
        } else { // initial case when is nil
        _ = circleWidth
            return capsuleWidth
        }
    }
}


//MARK: - Previews

struct CapsuleFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(translation: PassthroughSubject<CGFloat,Never>())
    }
}
