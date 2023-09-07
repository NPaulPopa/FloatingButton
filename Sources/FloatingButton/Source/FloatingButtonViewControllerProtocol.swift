//
//  File.swift
//  
//
//  Created by Paul on 07/09/2023.
//

import UIKit
import SwiftUI
import Combine

/// Step 1: simply add `setupButton()` in the ViewController's `init` and instantiate the floatingTableView with a custom TableView/CollectionView
public protocol FloatingButtonViewControllerProtocol: UIViewController, FloatingScrollDelegate {

    var screenSize: CGFloat { get }
    var floatingTableView: FloatingButtonScrollViewProtocol { get set }
    
    var swiftUICapsuleButton: FloatingButton! { get set }
    var translationPublisher: PassthroughSubject<CGFloat, Never>! { get set }
    var capsuleFloatingButton: UIView! { get set }
    
    func setupButton()
    func setupSwiftUIFloatingButton()
    func constrainFloatingButton()
}

//MARK: - Default implementations 

extension FloatingButtonViewControllerProtocol {
    
    public var screenSize: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public func setupButton() {
        setupSwiftUIFloatingButton()
        constrainFloatingButton()
    }
    
    public func constrainFloatingButton() {
        
        view.addSubview(capsuleFloatingButton)
        capsuleFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomSpacing: CGFloat = screenSize < 670 ? -60 : (-90 - 62)

        capsuleFloatingButton.layer.cornerRadius = swiftUICapsuleButton.capsuleHeight / 2
        
        NSLayoutConstraint.activate([
            
            capsuleFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: bottomSpacing),
            
            capsuleFloatingButton.widthAnchor.constraint(equalToConstant: swiftUICapsuleButton.capsuleWidth),
            
            capsuleFloatingButton.heightAnchor.constraint(equalToConstant: swiftUICapsuleButton.capsuleHeight),
                    
            capsuleFloatingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    public func setupSwiftUIFloatingButton() {
        translationPublisher = PassthroughSubject<CGFloat, Never>()
        swiftUICapsuleButton = FloatingButton(translation: translationPublisher)
        
        let hostingVC = UIHostingController(rootView: swiftUICapsuleButton)
        capsuleFloatingButton = hostingVC.view
    }
}
