//
//  CategoryListViewModel.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import Foundation
import Utils
import IdeaTrackerAPI

class CategoryListViewModel: ListViewModel<IdeaCategory> {
    
    // MARK: - Methods
    
    override func loadData() {
        isLoading?(true)
        client.getCategories { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let data):
                    self.onListSuccess?(data)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
    func createCategory(name: String) {
        isLoading?(true)
        client.createCategory(name) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let category):
                    self.onCreateSuccess?(category)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
    func deleteCategory(with id: UUID) {
        isLoading?(true)
        client.deleteCategory(withId: id) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success:
                    self.onDeleteSuccess?()
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
    func updateCategory(
        _ category: IdeaCategory,
        at index: Int
    ) {
        isLoading?(true)
        client.updateCategory(category) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let category):
                    self.onUpdateSuccess?(index, category)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
}
