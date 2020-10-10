//
//  CreateIdeaViewController.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import UIKit

class CreateIdeaViewController: BaseViewController {
    
    // MARK: - Properties
    
    var viewModel: CreateIdeaViewModel?
    
    private let sections: [Section] = [.name, .description, .user]
    
    // MARK: - UI elements
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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
    
    override func setupView() {
        // navigation attributes
        navigationItem.title = "New Idea"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(didPressSaveButton)
        )
        // set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CellWithTextField.self,
            forCellReuseIdentifier: CellWithTextField.reuseIdentifier
        )
        // set up the layout
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }
    
    override func setupBindings() {
        viewModel?.onSelectUser = { [weak self] in
            var set = IndexSet()
            set.insert(2)
            self?.tableView.reloadSections(set, with: .automatic)
        }
        // TODO: map error handler
        // TODO: map isloading
        // TODO: map create idea error
    }
    
    // MARK: - Interaction handling
    
    @objc func didPressSaveButton() {
        // get the name and description
        let section0 = IndexPath(item: 0, section: 0)
        let section1 = IndexPath(item: 0, section: 1)
        guard
            let name = (tableView.cellForRow(at: section0) as? CellWithTextField)?.textfield.text,
            let description = (tableView.cellForRow(at: section1) as? CellWithTextField)?.textfield.text
        else {
            return
        }
        viewModel?.saveIdea(name, description)
    }
    
}

extension CreateIdeaViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellWithTextField.reuseIdentifier, for: indexPath) as? CellWithTextField else {
            return UITableViewCell()
        }
        cell.configure(for: sections[indexPath.section].placeholder)
        // disable the user interaction in the 3rd section
        if indexPath.section == 2 {
            viewModel?.selectedUser.map { user in
                cell.textfield.placeholder = nil
                cell.textfield.text = user.username
            }
            cell.textfield.isUserInteractionEnabled = false
        } else {
            if indexPath.section == 1 {
                
            }
            cell.textfield.isUserInteractionEnabled = true
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        sections[section].title
    }
    
}

extension CreateIdeaViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        // TODO: introduce coordinator
        guard let users = viewModel?.users else { return }
        let viewController = SelectUserViewController()
        viewController.users = users
        viewController.onSelectUser = { [weak self] user in
            guard let viewModel = self?.viewModel else { return }
            viewModel.setUser(user)
        }
        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
    
}

private enum Section {
    
    case name
    case description
    case user
    
    var title: String {
        switch self {
        case .name: return "Name"
        case .description: return "Description"
        case .user: return "User"
        }
    }
    
    var placeholder: String {
        switch self {
        case .name: return "The name of the idea"
        case .description: return "A short description of the idea"
        case .user: return "The owner of this idea"
        }
    }
    
}
