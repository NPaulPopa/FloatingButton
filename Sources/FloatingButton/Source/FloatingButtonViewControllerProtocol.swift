//
//  File.swift
//  
//
//  Created by Paul on 07/09/2023.
//

import UIKit
import SwiftUI
import Combine

/// Use this on a UIViewController subclass to show a floating button that changes its bounds when scrolling beyond a certain treshold
/// - Step 1: Add `setupFloatingButton()` in the ViewController's `init`
/// - Step 2: Add `constrainFloatingButton()` AFTER `setupFloatingButton()`

/// ```
/// class ViewController: FloatingButtonViewControllerProtocol {
///
///   init() {
///        super.init(nibName: nil, bundle: nil)
///        setupFloatingButton()
///        constrainFloatingButton()
///      }
/// }
/// ```
/// - Step 3: Instantiate the floatingTableView with a custom instance of TableView/CollectionView conforming to FloatingButtonScrollViewProtocol
///
/// ```
/// lazy var floatingTableView: FloatingButtonScrollViewProtocol = customTableView
///
/// ```
public protocol FloatingButtonViewControllerProtocol: UIViewController, FloatingScrollDelegate {
    
    //MARK: - Required
    
    var floatingTableView: FloatingButtonScrollViewProtocol { get }
    var capsuleFloatingButton: UIView! { get set }
    
    //MARK: - Optional

    var screenSize: CGFloat { get }
    func setupFloatingButton()
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
    
    var swiftUICapsuleButton: FloatingButton {
        FloatingButton()
    }
    
    public func setupFloatingButton() {
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
                        
        let hostingVC = UIHostingController(rootView: swiftUICapsuleButton)
        capsuleFloatingButton = hostingVC.view
        
        floatingTableView.floatingScrollDelegate = self
    }
    
    //MARK: FloatingScroll Delegate
    
    public func updateFloatingButtonConstraints() {
        self.capsuleFloatingButton.invalidateIntrinsicContentSize()
    }
    
    public func revertFloatingButtonConstraintsBackToNormal() {
//        UIView.animate(withDuration: 1.2, delay: 0.0, options: .curveEaseInOut) {
//            self.capsuleFloatingButton.alpha = 0
//            
//        } completion: { _ in
//           self.capsuleFloatingButton.alpha = 1
//            self.capsuleFloatingButton.invalidateIntrinsicContentSize()
//        }
    }
}
