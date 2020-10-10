//
//  UserListCell.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import UIKit
import IdeaTrackerAPI

class UserListCell: BaseCell<PublicUserData>, ConfigurableCell {
    
    static let reuseIdentifier = "UserListCell"
    
    // MARK: - UI elements
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func initializeView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    // MARK: - Methods
    
    override func configure(for user: PublicUserData) {
        usernameLabel.text = user.username
        nameLabel.text = "\(user.name) (\(user.id.shortString))"
    }
    
}
