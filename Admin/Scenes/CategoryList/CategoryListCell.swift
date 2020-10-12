//
//  CategoryListCell.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import Foundation
import UIKit
import Utils
import IdeaTrackerAPI

class CategoryListCell: BaseCell<IdeaCategory>, ConfigurableCell {
    
    static let reuseIdentifier: String = "CategoryListCell"
    
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
    
    override func configure(for category: IdeaCategory) {
        containerView.titleLabel.text = category.name
        containerView.idLabel.text = "ID: \(category.id.shortString)"
    }
    
}
