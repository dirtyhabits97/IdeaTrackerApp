//
//  ListDataSource.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import UIKit

public protocol ConfigurableCell: UITableViewCell {
    
    associatedtype Model
    
    static var reuseIdentifier: String { get }
    
    func configure(for: Model)
    
}

public final class ListDataSource<
    Item,
    Cell: ConfigurableCell
>:
    NSObject, UITableViewDataSource, UITableViewDelegate

where Cell.Model == Item {
    
    // MARK: - Properties
    
    public var displayedItems: [Item] = []
    
    private weak var tableView: UITableView?
    
    // MARK: - Observables
    
    public var willDelete: ((Item) -> Void)?
    public var didSelect:  ((Int, Item) -> Void)?
    
    // MARK: - Lifecycle
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.register(
            Cell.self,
            forCellReuseIdentifier: Cell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        // set up the header and footer
        
    }
    
    // MARK: - DataSource methods
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        displayedItems.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(for: displayedItems[indexPath.row])
        return cell
    }
    
    public func tableView(
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
    
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: false)
        didSelect?(indexPath.row, displayedItems[indexPath.row])
    }
    
    // MARK: - Helper methods
    
    public func appendItem(_ item: Item) {
        displayedItems.append(item)
        self.tableView?.insertRows(
            at: [IndexPath(row: self.displayedItems.count-1, section: 0)],
            with: .automatic
        )
    }
    
    public func replaceItem(at index: Int, with item: Item) {
        displayedItems[index] = item
        self.tableView?.reloadRows(
            at: [IndexPath(row: index, section: 0)],
            with: .automatic
        )
    }
    
}
