//
//  CategoryListCell.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import Foundation
import UIKit
import IdeaTrackerAPI

class CategoryListCell: BaseCell<IdeaCategory>, ConfigurableCell {
    
    static let reuseIdentifier: String = "CategoryListCell"
    
    // MARK: - UI elements
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func initializeView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(idLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    override func configure(for category: IdeaCategory) {
        nameLabel.text = category.name
        if let id = category.id?.shortString {
            idLabel.text = "(\(id))"
        }
        idLabel.isHidden = category.id == nil
    }
    
}
