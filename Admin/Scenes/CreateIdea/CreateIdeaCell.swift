//
//  CreateIdeaCell.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/7/20.
//

import UIKit

class CreateIdeaCell: BaseCell<CreateIdeaViewController.Section> {
    
    static let reuseIdentifier: String = "CreateIdeaCell"
    
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
    
    override func configure(for model: CreateIdeaViewController.Section) {
        // set the placeholder
        textfield.placeholder = model.placeholder
        // check the value to display
        switch model {
        case .name(let name):
            textfield.text = name
            textfield.isUserInteractionEnabled = true
        case .description(let description):
            textfield.text = description
            textfield.isUserInteractionEnabled = true
        case .user(let user):
            textfield.text = user
            textfield.isUserInteractionEnabled = false
        }
    }
    
}
