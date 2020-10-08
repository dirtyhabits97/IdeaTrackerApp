//
//  IdeaListViewController.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import UIKit
import IdeaTrackerAPI

class IdeaListViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var errorHandler: ErrorHandler?
    
    var viewModel: IdeaListViewModel?
    
    var displayedIdeas: [Idea] = []
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.loadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        // navigation attributes
        navigationItem.title = "Ideas"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddIdeaButton)
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
            IdeaListCell.self,
            forCellReuseIdentifier: IdeaListCell.reuseIdentifier
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
        viewModel?.onListSucess = { [weak self] ideas in
            guard let self = self else { return }
            self.displayedIdeas = ideas
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Interaction handling
    
    @objc func didPullToRefresh() {
        viewModel?.loadData()
    }
    
    @objc func didPressAddIdeaButton() {
        // TODO: introduce coordinator
        guard let viewModel = viewModel else { return }
        let viewController = CreateIdeaViewController()
        viewController.viewModel = CreateIdeaViewModel(client: viewModel.client)
        // TODO: set the error handler from the coordinator
        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
    
}

extension IdeaListViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        displayedIdeas.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IdeaListCell.reuseIdentifier, for: indexPath) as? IdeaListCell else {
            return UITableViewCell()
        }
        cell.configure(for: displayedIdeas[indexPath.row])
        return cell
    }
    
}

extension IdeaListViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
