//
//  ViewController.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import UIKit
import IdeaTrackerAPI

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: UserListViewModel?
    
    var displayedUsers: [PublicUserData] = []
    
    // MARK: - UI elements
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel?.loadData()
    }
    
    private func setupView() {
        // navigation attributes
        navigationItem.title = "Users"
        // set up the tableview
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UserListCell.self,
            forCellReuseIdentifier: UserListCell.reuseIdentifier
        )
        // set up the layout
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupBindings() {
        viewModel?.onFailure = { error in
            print(error.localizedDescription)
            print(error)
        }
        viewModel?.onSucess = { [weak self] users in
            print("success")
            self?.displayedUsers = users
            self?.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        displayedUsers.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.reuseIdentifier, for: indexPath) as? UserListCell else {
            return UITableViewCell()
        }
        cell.configure(for: displayedUsers[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    
    
}
