//
//  ViewController.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import UIKit
import IdeaTrackerAPI

// TODO: create toast view to notify changes
class UserListViewController: ListViewController {
    
    // MARK: - Properties
        
    var viewModel: UserListViewModel?
    var dataSource: ListDataSource<PublicUserData, UserListCell>?
    
    var displayedUsers: [PublicUserData] {
        get { dataSource?.displayedItems ?? [] }
        set { dataSource?.displayedItems = newValue }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadData()
    }
    
    override func setupView() {
        super.setupView()
        // navigation attributes
        navigationItem.title = "Users"
        // create the data source
        dataSource = ListDataSource(tableView: tableView)
    }
    
    override func setupBindings() {
        // MARK: view model bindings
        viewModel?.isLoading = { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                // TODO: show and indicator
            } else {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
        viewModel?.onFailure = { [weak self] error in
            guard let self = self else { return }
            var message = ""
            message += "description: \(error.localizedDescription)\n"
            message += "error:\n\(error)"
            self.errorHandler?.handleError(message)
        }
        viewModel?.onListSuccess = { [weak self] users in
            guard let self = self else { return }
            self.displayedUsers = users
            self.tableView.reloadData()
        }
        viewModel?.onCreateSuccess = { [weak self] user in
            guard let self = self else { return }
            self.dataSource?.appendItem(user)
        }
        viewModel?.onDeleteSuccess = {
            print("deleted user")
        }
        // MARK: data source bindings
        dataSource?.willDelete = { [weak self] user in
            self?.viewModel?.deleteUser(withId: user.id)
        }
        dataSource?.didSelect = { user in
            UIPasteboard.general.string = user.id.uuidString
        }
    }
    
    // MARK: - Interaction handling
    
    override func didPressAddItemButton() {
        let alert = UIAlertController(title: "New user", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { $0.placeholder = "name" })
        alert.addTextField(configurationHandler: { $0.placeholder = "username" })
        alert.addTextField(configurationHandler: { $0.placeholder = "password" })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] (_) in
            guard
                let name = alert.textFields?[0].text,
                let username = alert.textFields?[1].text,
                let password = alert.textFields?[2].text
            else {
                return
            }
            self?.viewModel?.createUser(name: name, username: username, password: password)
        }))
        present(alert, animated: true)
    }
    
    override func didPullToRefresh() {
        viewModel?.loadData()
    }
    
}
