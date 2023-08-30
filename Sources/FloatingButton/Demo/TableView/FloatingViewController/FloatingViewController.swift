//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import UIKit
import SwiftUI
import Combine

public class FloatingButtonViewController: UIViewController, FloatingScrollDelegate {
    
    var buttonWidthConstraint: NSLayoutConstraint!
    var buttonHeightConstraint: NSLayoutConstraint!
        
    //MARK: - Properties
        
    var translation = PassthroughSubject<CGFloat, Never>()
    private var capsuleFloatingButton: UIView!
    
    var capsuleHeight: CGFloat!
    var capsuleWidth: CGFloat!
    
    lazy var swiftUICapsuleButton = FloatingButton(translation: translation)
    
    lazy var floatingTableView = FloatingButtonTableView(translation: translation)
    
    private var capsuleCenterYConstraint: NSLayoutConstraint!
    
    public init() { super.init(nibName: nil, bundle: nil) }
    required init?(coder: NSCoder) { fatalError("not been implemented") }
    
    //MARK: - View DidLoad

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        floatingTableView.floatingScrollDelegate = self
        
        let hostingVC = UIHostingController(rootView: swiftUICapsuleButton)
        self.capsuleFloatingButton = hostingVC.view
        
        self.capsuleWidth = swiftUICapsuleButton.capsuleWidth
        self.capsuleHeight = swiftUICapsuleButton.capsuleHeight
        
        constrainTableView()
        constrainCapsuleFloatingButton()
    }
        
    //MARK: - Constraints
    
    func constrainTableView() {
        
        floatingTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingTableView)

        NSLayoutConstraint.activate([
        
            floatingTableView.topAnchor.constraint(equalTo: view.topAnchor),
            floatingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            floatingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            floatingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func constrainCapsuleFloatingButton() {
            
        view.addSubview(capsuleFloatingButton)
        
        capsuleFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        capsuleCenterYConstraint = capsuleFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -60)

        buttonWidthConstraint = capsuleFloatingButton.widthAnchor.constraint(equalToConstant: capsuleWidth)
        
        buttonHeightConstraint = capsuleFloatingButton.heightAnchor.constraint(equalToConstant: capsuleHeight)
       
        capsuleFloatingButton.layer.cornerRadius = capsuleHeight / 2
        
        NSLayoutConstraint.activate([
                    
            capsuleFloatingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            capsuleCenterYConstraint,
            buttonWidthConstraint,
            buttonHeightConstraint
        ])
    }
    
    //MARK: - Constraints Updating
    
    public func updateFloatingButtonConstraints() {
        
        buttonWidthConstraint.constant = 44.4
      //  buttonHeightConstraint.constant = 44.4
        self.capsuleFloatingButton.layer.cornerRadius = 44.4 / 2
    }
    
    public func updateFloatingButtonConstraintsBackToNormal() {
        
        buttonWidthConstraint.constant = capsuleWidth
      //  buttonHeightConstraint.constant = capsuleHeight
    }
}
