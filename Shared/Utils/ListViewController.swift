//
//  ListViewController.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import UIKit

open class ListViewController: BaseViewController {
    
    // MARK: - UI elements
    
    public let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    open override func setupView() {
        super.setupView()
        // navigation items
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(didPressEditModeButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAddItemButton)
        )
        // refresh controller
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(didPullToRefresh),
            for: .valueChanged
        )
        tableView.refreshControl = refreshControl
        // tableview configuration
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        // set up the layout
        view.addSubview(tableView)
        tableView.pinToSuperview()
    }
    
    // MARK: - Interaction handling
    
    @objc open func didPressAddItemButton() {
        // TODO: override this
    }
    
    @objc open func didPressEditModeButton() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            navigationItem.leftBarButtonItem?.title = "Done"
        } else {
            navigationItem.leftBarButtonItem?.title = "Edit"
        }
    }
    
    @objc open func didPullToRefresh() {
        // TODO: override this
    }
    
}

