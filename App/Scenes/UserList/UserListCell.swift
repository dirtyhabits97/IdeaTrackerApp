//
//  UserListCell.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import UIKit
import IdeaTrackerAPI

class UserListCell: UITableViewCell {
    
    static let reuseIdentifier = "UserListCell"
    
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
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeView()
    }
    
    func initializeView() {
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
    
    func configure(for user: PublicUserData) {
        usernameLabel.text = user.username
        var text = user.name
        if let id = user.id?.uuidString {
            let short = id[id.startIndex..<id.index(id.startIndex, offsetBy: 8)]
            text += " (\(short))"
        }
        nameLabel.text = text
    }
    
}
