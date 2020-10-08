//
//  ViewController.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import UIKit
import IdeaTrackerAPI

protocol ErrorHandler: AnyObject {
    
    func handleError(_ message: String)
    
}

// TODO: create toast view to notify changes
class UserListViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var errorHandler: ErrorHandler?
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(didPressEditModeButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddUserButton)
        )
        // refresh controller
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(didPullToRefresh),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
        // set up the tableview
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UserListCell.self,
            forCellReuseIdentifier: UserListCell.reuseIdentifier
        )
        // set up the layout
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }
    
    private func setupBindings() {
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
        viewModel?.onListSucess = { [weak self] users in
            guard let self = self else { return }
            self.displayedUsers = users
            self.tableView.reloadData()
        }
        viewModel?.onCreateSuccess = { [weak self] user in
            guard let self = self else { return }
            self.displayedUsers.append(user)
            self.tableView.insertRows(at: [IndexPath(item: self.displayedUsers.count-1, section: 0)], with: .automatic)
        }
        viewModel?.onDeleteSuccess = {
            print("deleted user")
        }
    }
    
    // MARK: - Interaction handling
    
    @objc func didPressAddUserButton() {
        let alert = UIAlertController(title: "Add user", message: nil, preferredStyle: .alert)
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
    
    @objc func didPressEditModeButton() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            navigationItem.leftBarButtonItem?.title = "Done"
        } else {
            navigationItem.leftBarButtonItem?.title = "Edit"
        }
    }
    
    @objc func didPullToRefresh() {
        viewModel?.loadData()
    }
    
}

extension UserListViewController: UITableViewDataSource {
    
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
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        // model updates
        viewModel?.deleteUser(withId: displayedUsers[indexPath.row].id)
        // view updates
        displayedUsers.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let id = displayedUsers[indexPath.row].id?.uuidString else { return }
        UIPasteboard.general.string = id
    }
    
}
