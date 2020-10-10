//
//  CategoryListViewController.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import UIKit
import IdeaTrackerAPI

class CategoryListViewController: ListViewController {
    
    // MARK: - Properties
    
    var viewModel: CategoryListViewModel?
    var dataSource: ListDataSource<IdeaCategory, CategoryListCell>?
    
    var displayedCategories: [IdeaCategory] {
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
        navigationItem.title = "Categories"
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
        viewModel?.onListSucess = { [weak self] categories in
            guard let self = self else { return }
            self.displayedCategories = categories
            self.tableView.reloadData()
        }
        viewModel?.onCreateSuccess = { [weak self] category in
            guard let self = self else { return }
            self.dataSource?.appendItem(category)
        }
        viewModel?.onDeleteSuccess = {
            print("deleted category")
        }
        // MARK: data source bindings
        dataSource?.willDelete = { [weak self] category in
            guard let self = self, let id = category.id else { return }
            self.viewModel?.deleteCategory(with: id)
        }
        dataSource?.didSelect = { category in
            guard let id = category.id?.uuidString else { return }
            UIPasteboard.general.string = id
        }
    }
    
    // MARK: - Interaction handling
    
    override func didPullToRefresh() {
        viewModel?.loadData()
    }
    
    override func didPressAddItemButton() {
        let alert = UIAlertController(title: "New category", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { $0.placeholder = "name" })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] (_) in
            guard let name = alert.textFields?[0].text else { return }
            self?.viewModel?.createCategory(name: name)
        }))
        present(alert, animated: true)
    }
    
}
