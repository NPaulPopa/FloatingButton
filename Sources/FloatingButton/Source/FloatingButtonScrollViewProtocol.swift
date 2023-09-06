//
//  File.swift
//  
//
//  Created by Paul on 07/09/2023.
//

import UIKit
import Combine

public protocol FloatingButtonScrollViewProtocol: UIScrollView {
    
    var floatingScrollDelegate: FloatingScrollDelegate? { get set }
    var translationPublisher: PassthroughSubject<CGFloat, Never> { get set }
    
    ///This method `must be called inside a scrollView's scrollViewDidScroll(_:) method`
    /// - It sends the current vertical contentOffset to the translationPublisher's subcribers
    /// - If `contentOffset => -64` the user is dragging up and the `floatingScrollDelegate` is called, the Button's constraints are updated - `circle mode`
    /// - If `contentOffset < -64` the user is dragging down and the `floatingScrollDelegate` is called, reverting the Button's constraints back to normal - `capsule mode`
    func handleScrollViewThreshold(_ scrollView: UIScrollView)
}

extension FloatingButtonScrollViewProtocol {
    
    public func handleScrollViewThreshold(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.y
        
        translationPublisher.send(contentOffset)
        
        if contentOffset > 0 {

        if contentOffset >= -64 {
            floatingScrollDelegate?.updateFloatingButtonConstraints()
        }

        }

        if contentOffset < -64 {
           floatingScrollDelegate?.updateFloatingButtonConstraintsBackToNormal()
        }
    }
}
