//
//  ListDataSource.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import UIKit

protocol ConfigurableCell: UITableViewCell {
    
    associatedtype Model
    
    static var reuseIdentifier: String { get }
    
    func configure(for: Model)
    
}

class ListDataSource<Item, Cell: ConfigurableCell>: NSObject, UITableViewDataSource, UITableViewDelegate where Cell.Model == Item {
    
    // MARK: - Properties
    
    var displayedItems: [Item] = []
    
    // MARK: - Observables
    
    var willDelete: ((Item) -> Void)?
    var didSelect:  ((Item) -> Void)?
    
    // MARK: - Lifecycle
    
    init(tableView: UITableView) {
        super.init()
        tableView.register(
            Cell.self,
            forCellReuseIdentifier: Cell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - DataSource methods
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        displayedItems.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(for: displayedItems[indexPath.row])
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        // model updates
        willDelete?(displayedItems[indexPath.row])
        // view updates
        displayedItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Delete methods
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        didSelect?(displayedItems[indexPath.row])
    }
    
}
