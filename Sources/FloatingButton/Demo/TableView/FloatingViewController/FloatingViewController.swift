//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import UIKit
import SwiftUI
import Combine

public class FloatingButtonViewController: UIViewController, FloatingButtonViewControllerProtocol {
        
    //MARK: - Button Constraints
    
    public var buttonWidthConstraint: NSLayoutConstraint!
    public var buttonHeightConstraint: NSLayoutConstraint!
    public var buttonBottomConstraint: NSLayoutConstraint!
   
    //MARK: - Properties
        
    public var translationPublisher: PassthroughSubject<CGFloat, Never>!
    public var swiftUICapsuleButton: FloatingButton!
    public var capsuleFloatingButton: UIView!
    
    public lazy var floatingTableView: FloatingButtonScrollViewProtocol = FloatingButtonTableView()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupFloatingButton()
    }
    
    required init?(coder: NSCoder) { fatalError("not been implemented") }
    
    //MARK: - View DidLoad

    public override func viewDidLoad() {
        super.viewDidLoad()
        constrainTableView()
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
}
