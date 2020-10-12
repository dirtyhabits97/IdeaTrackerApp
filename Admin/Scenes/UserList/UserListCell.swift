//
//  UserListCell.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import UIKit
import Utils
import IdeaTrackerAPI

class UserListCell: BaseCell<PublicUserData>, ConfigurableCell {
    
    static let reuseIdentifier = "UserListCell"
    
    // MARK: - UI elements
    
    let containerView: TitleWithIdView = {
        let view = TitleWithIdView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func initializeView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: - Methods
    
    override func configure(for user: PublicUserData) {
        containerView.titleLabel.text = user.username
        var id = ""
        id += "ID: \(user.id.shortString)\n"
        id += "NAME: \(user.name)"
        containerView.idLabel.text = id
    }
    
}
