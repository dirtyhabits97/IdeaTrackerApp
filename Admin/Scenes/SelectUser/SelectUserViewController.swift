//
//  SelectUserViewController.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import UIKit
import Utils
import IdeaTrackerAPI

class SelectUserViewController: UITableViewController {
    
    var users: [PublicUserData] = []
    
    var onSelectUser: ((PublicUserData) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        navigationItem.largeTitleDisplayMode = .never
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        users.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(for: users[indexPath.row])
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        onSelectUser?(users[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

private class Cell: BaseCell<PublicUserData> {
    
    static let reuseIdentifier: String = "Cell"
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func initializeView() {
        addSubview(usernameLabel)
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            usernameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    override func configure(for model: PublicUserData) {
        usernameLabel.text = model.username
    }
    
}
