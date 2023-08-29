//
//  File.swift
//  
//
//  Created by Paul on 29/08/2023.
//

import UIKit

class FloatingTableViewDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - Data
    
    let mockDataGenerator = MockDataGenerator()
    lazy var mockData = mockDataGenerator.generateMockData()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
                
        cell.textLabel?.text = mockData[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Futura", size: 16)
        
        return cell
    }
    
    //MARK: - Rows

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return mockData.count }
}
