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
