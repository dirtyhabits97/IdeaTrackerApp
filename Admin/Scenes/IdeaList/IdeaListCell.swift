//
//  IdeaListCell.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import UIKit
import Utils
import IdeaTrackerAPI

class IdeaListCell: BaseCell<Idea>, ConfigurableCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "IdeaListCell"
    
    // MARK: - UI elements
    
    let containerView: TitleWithIdView = {
        let view = TitleWithIdView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.2, alpha: 1)
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func initializeView() {
        contentView.addSubview(containerView)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
    }
    
    // MARK: - Methods
    
    override func configure(for idea: Idea) {
        containerView.titleLabel.text = idea.name
        var id = ""
        id += "ID: \(idea.id.shortString)\n"
        id += "USER ID: \(idea.userId.shortString)"
        containerView.idLabel.text = id
        descriptionLabel.text = idea.description
    }
    
}

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeView()
    }
    
    func initializeView() {
        
    }
    
}

class TitleWithIdView: BaseView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 2
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
    
    override func initializeView() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(idLabel)
        addSubview(copyIdButton)
        // constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            copyIdButton.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor, constant: 16),
            copyIdButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            copyIdButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            copyIdButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        // content constraints
        copyIdButton.setContentHuggingPriority(.required, for: .horizontal)
        copyIdButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
}
