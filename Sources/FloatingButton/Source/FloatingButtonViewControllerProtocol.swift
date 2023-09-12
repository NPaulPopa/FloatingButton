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
    
    var capsuleHeight: CGFloat {
        swiftUICapsuleButton.capsuleHeight
    }
    
    public func setupButton() {
        setupSwiftUIFloatingButton()
    }
    
    public func constrainFloatingButton() {
        
        view.addSubview(capsuleFloatingButton)
        capsuleFloatingButton.translatesAutoresizingMaskIntoConstraints = false

        let bottomSpacing: CGFloat = screenSize < 670 ? -60 : (-90) //(-90 - 62)

        capsuleFloatingButton.layer.cornerRadius = capsuleHeight / 2

        NSLayoutConstraint.activate([

            capsuleFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: bottomSpacing),
            capsuleFloatingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    public func setupSwiftUIFloatingButton() {
        swiftUICapsuleButton = FloatingButton()
                        
        let hostingVC = UIHostingController(rootView: swiftUICapsuleButton)
        capsuleFloatingButton = hostingVC.view
        
        floatingTableView.floatingScrollDelegate = self
    }
    
    //MARK: FloatingScroll Delegate
    
    public func updateFloatingButtonConstraints() {
        self.capsuleFloatingButton.invalidateIntrinsicContentSize()
    }
    
    public func updateFloatingButtonConstraintsBackToNormal() {
        self.capsuleFloatingButton.invalidateIntrinsicContentSize()
    }
}
