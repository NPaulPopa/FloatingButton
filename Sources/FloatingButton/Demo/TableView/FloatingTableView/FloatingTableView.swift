//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import UIKit
import Combine

public protocol FloatingScrollDelegate: AnyObject {
    
    func updateFloatingButtonConstraints()
    func updateFloatingButtonConstraintsBackToNormal()
}

public class FloatingButtonTableView: UITableView, UITableViewDelegate {
    
    //MARK: - Properties
    
   public weak var floatingScrollDelegate: FloatingScrollDelegate?
    
    var translation: PassthroughSubject<CGFloat, Never>
    private let floatingDataSource = FloatingTableViewDataSource()

    public init(translation: PassthroughSubject<CGFloat, Never>) {
        self.translation = translation
        
        super.init(frame: .zero,style: .plain)
        configure()
    }

}
