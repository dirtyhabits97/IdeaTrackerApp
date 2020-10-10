//
//  IdeaListViewController.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import UIKit
import IdeaTrackerAPI

class IdeaListViewController: ListViewController {
    
    // MARK: - Properties
        
    var viewModel: IdeaListViewModel?
    var dataSource: ListDataSource<Idea, IdeaListCell>?
    
    var displayedIdeas: [Idea] {
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
        navigationItem.title = "Ideas"
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
        viewModel?.onListSucess = { [weak self] ideas in
            guard let self = self else { return }
            self.displayedIdeas = ideas
            self.tableView.reloadData()
        }
        viewModel?.onDeleteSuccess = {
            print("deleted idea")
        }
        // MARK: data source bindings
        dataSource?.willDelete = { [weak self] idea in
            self?.viewModel?.deleteIdea(with: idea.id)
        }
    }
    
    // MARK: - Interaction handling
    
    override func didPullToRefresh() {
        viewModel?.loadData()
    }
    
    override func didPressAddItemButton() {
        // TODO: introduce coordinator
        guard let viewModel = viewModel else { return }
        let viewController = CreateIdeaViewController()
        viewController.viewModel = CreateIdeaViewModel(client: viewModel.client)
        viewController.viewModel?.onCreateIdeaSuccess = { [weak self] idea in
            guard let self = self else { return }
            // go back 1 screen
            self.navigationController?.popViewController(animated: true)
            self.dataSource?.appendItem(idea)
        }
        // TODO: set the error handler from the coordinator
        navigationController?.pushViewController(
            viewController,
            animated: true
        )
    }
    
}
