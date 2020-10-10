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
    
    let copyIdButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  COPY ID  ", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func initializeView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(idLabel)
        contentView.addSubview(copyIdButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            copyIdButton.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: 16),
            copyIdButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            copyIdButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            copyIdButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        copyIdButton.setContentHuggingPriority(.required, for: .horizontal)
        copyIdButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    override func configure(for category: IdeaCategory) {
        nameLabel.text = category.name
        idLabel.text = "ID: \(category.id.shortString)"
    }
    
}
