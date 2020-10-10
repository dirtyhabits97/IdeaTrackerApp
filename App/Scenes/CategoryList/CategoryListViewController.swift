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
    
    // MARK: - UI elements
    
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
        viewModel?.onListSuccess = { [weak self] categories in
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
        viewModel?.onUpdateSuccess = { [weak self] (idx, category) in
            guard let self = self else { return }
            self.dataSource?.replaceItem(at: idx, with: category)
        }
        // MARK: data source bindings
        dataSource?.willDelete = { [weak self] category in
            guard let self = self else { return }
            self.viewModel?.deleteCategory(with: category.id)
        }
        dataSource?.didSelect = { [weak self] (idx, category) in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Update category", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: {
                $0.placeholder = "name"
                $0.text = category.name
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [weak self] (_) in
                guard
                    let self = self,
                    let name = alert.textFields?[0].text, name != category.name
                else {
                    return
                }
                self.viewModel?.updateCategory(self.displayedCategories[idx], at: idx)
            }))
            self.present(alert, animated: true)
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
