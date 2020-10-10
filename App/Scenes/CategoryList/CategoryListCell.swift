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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(copyIdButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            copyIdButton.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.leadingAnchor, constant: 16),
            copyIdButton.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            copyIdButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            copyIdButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        copyIdButton.setContentHuggingPriority(.required, for: .horizontal)
        copyIdButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    override func configure(for category: IdeaCategory) {
        let text = NSMutableAttributedString(
            string: category.name,
            font: .preferredFont(forTextStyle: .headline)
        )
        text.append(
            string: "\nID: \(category.id.shortString)",
            font: .preferredFont(forTextStyle: .footnote),
            color: .systemGray
        )
        nameLabel.attributedText = text
    }
    
}
