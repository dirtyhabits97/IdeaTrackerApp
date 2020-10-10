//
//  CellWithTextField.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/7/20.
//

import UIKit

class CellWithTextField: BaseCell<String> {
    
    static let reuseIdentifier: String = "CellWithTextField"
    
    let textfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    override func initializeView() {
        contentView.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            textfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    override func configure(for model: String) {
        textfield.placeholder = model
    }
    
}
