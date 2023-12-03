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
    func revertFloatingButtonConstraintsBackToNormal()
}

public class FloatingButtonTableView: UITableView, UITableViewDelegate, FloatingButtonScrollViewProtocol {
    
    public weak var floatingScrollDelegate: FloatingScrollDelegate?
    
    //MARK: - Properties

    private let floatingDataSource = FloatingTableViewDataSource()

    public init() {
        super.init(frame: .zero,style: .plain)
        configure()
    }

    public required init?(coder: NSCoder) { fatalError("Not implemented") }
    
    //MARK: - View Configuration
    
    private func configure() {
        registerCell()
        configureDelegates()
    }
    
    //MARK: - Delegates Configuration

    private func configureDelegates() {
        self.delegate = self
        self.dataSource = floatingDataSource
        self.delaysContentTouches = false
    }
    
    private func registerCell() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
        
    //MARK: - ScrollView Methods

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleScrollViewThreshold(scrollView)
    }
}
