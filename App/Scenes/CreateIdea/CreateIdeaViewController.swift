//
//  CreateIdeaViewController.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import UIKit

// TODO: improve text handling here
class CreateIdeaViewController: BaseViewController {
    
    // MARK: - Properties
    
    var viewModel: CreateIdeaViewModel?
    
    private var displayedSections: [Section] = []
    
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
        navigationItem.rightBarButtonItem?.isEnabled = false
        // set up table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CreateIdeaCell.self,
            forCellReuseIdentifier: CreateIdeaCell.reuseIdentifier
        )
        // set up the layout
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }
    
    override func setupBindings() {
        viewModel?.onSelectUser = { [weak self] user in
            guard let self = self else { return }
            var set = IndexSet()
            set.insert(2)
            self.displayedSections[2] = .user(user)
            self.tableView.reloadSections(set, with: .automatic)
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        viewModel?.onListSuccess = { [weak self] sections in
            guard let self = self else { return }
            self.displayedSections = sections
            self.tableView.reloadData()
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
            let name = (tableView.cellForRow(at: section0) as? CreateIdeaCell)?.textfield.text,
            let description = (tableView.cellForRow(at: section1) as? CreateIdeaCell)?.textfield.text
        else {
            return
        }
        viewModel?.saveIdea(name, description)
    }
    
}

extension CreateIdeaViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        displayedSections.count
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateIdeaCell.reuseIdentifier, for: indexPath) as? CreateIdeaCell else {
            return UITableViewCell()
        }
        cell.configure(for: displayedSections[indexPath.section])
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        displayedSections[section].title
    }
    
}

extension CreateIdeaViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        // TODO: introduce coordinator
        guard let users = viewModel?.users, !users.isEmpty else { return }
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

extension CreateIdeaViewController {
    
    enum Section {
        
        case name(String?)
        case description(String?)
        case user(String?)
        
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
    
}
