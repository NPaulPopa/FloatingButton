//
//  File.swift
//  
//
//  Created by Paul on 07/09/2023.
//

import UIKit
import Combine

/// Step 1: Add `weak var floatingScrollDelegate: FloatingScrollDelegate?`
/// Step 2: Add UiCollectionVIew/TableViewDelegate conformance and set self as delegate
/// Step 3: Call `handleScrollViewThreshold(_:)` inside the `scrollViewDidScroll` delegate method
/// ```
/// class TableView: FloatingButtonScrollViewProtocol, UITableViewDelegate {
///
///  //Step 1 Add weak reference to floatingScrollDelegate
///  public weak var floatingScrollDelegate: FloatingScrollDelegate?
///
///  //Step 2 Set self as UICollectionView/TableViewDelegate
///  init() {
///       super.init(frame: .zero)
///       delegate = self
///     }
/// }
///
///  //Step 3 Call handleScrollViewThreshold(_:) inside scrollViewDidScroll(_:) delegate method
///  func scrollViewDidScroll(_ scrollView: UIScrollView) {
///     handleScrollViewThreshold(scrollView)
/// }
/// ```
///  - Tip: remember to add UIScrollViewConformance and set self as the delegate
public protocol FloatingButtonScrollViewProtocol: UIScrollView, UIScrollViewDelegate {
    
    var floatingScrollDelegate: FloatingScrollDelegate? { get set }
  //  var translationPublisher: PassthroughSubject<CGFloat, Never> { get set }
    
    ///This method `must be called inside a scrollView's scrollViewDidScroll(_:) method`
    /// - It sends the current vertical contentOffset to the translationPublisher's subcribers
    /// - If `contentOffset => -64` the user is dragging up and the `floatingScrollDelegate` is called, the Button's constraints are updated - `circle mode`
    /// - If `contentOffset < -64` the user is dragging down and the `floatingScrollDelegate` is called, reverting the Button's constraints back to normal - `capsule mode`
    func handleScrollViewThreshold(_ scrollView: UIScrollView)
    func handleScrollViewThreshold(using contentOffset: CGFloat)
    func handleScrollViewThreshold(usingRevert contentOffset: CGFloat)
}

extension FloatingButtonScrollViewProtocol {
    
    public func handleScrollViewThreshold(_ scrollView: UIScrollView) {
        
        let contentOffset = scrollView.contentOffset.y
        
        NotificationCenter.default.post(name: .translationDidChange, object: contentOffset)
        
        if contentOffset > 0 {
            
            if contentOffset >= -64 {
                floatingScrollDelegate?.updateFloatingButtonConstraints()
            }
        }
        
        if contentOffset < -64 {
            floatingScrollDelegate?.revertFloatingButtonConstraintsBackToNormal()
        }
    }
    
    public func handleScrollViewThreshold(using contentOffset: CGFloat) {
                
//        NotificationCenter.default.post(name: .translationDidChange, object: contentOffset)
        
     //   if contentOffset > 0 {
            
          //  if contentOffset >= -64 {
                floatingScrollDelegate?.updateFloatingButtonConstraints()
          //  }
      //  }
        
//        if contentOffset < -64 {
//            floatingScrollDelegate?.revertFloatingButtonConstraintsBackToNormal()
//        }
    }
    
    public func handleScrollViewThreshold(usingRevert contentOffset: CGFloat) {
                
     //   NotificationCenter.default.post(name: .translationDidChange, object: contentOffset)
        
//        if contentOffset > 0 {
//
//            if contentOffset >= -64 {
//                floatingScrollDelegate?.updateFloatingButtonConstraints()
//            }
//        }
        
      //  if contentOffset < -64 {
            floatingScrollDelegate?.revertFloatingButtonConstraintsBackToNormal()
      //  }
    }
}
