//
//  IdeaListViewModel.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import IdeaTrackerAPI

class IdeaListViewModel {
    
    // MARK: - Properties
    
    let client: IdeaTrackerClient
    
    // MARK: - Callbacks
    
    var isLoading: ((Bool) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    var onListSucess: (([Idea]) -> Void)?
    var onDeleteSuccess: (() -> Void)?
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient) {
        self.client = client
    }
    
    // MARK: - Methods
    
    func loadData() {
        isLoading?(true)
        client.getIdeas { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let data):
                    self.onListSucess?(data)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
        
    }
    
    func deleteIdea(with id: UUID?) {
        guard let id = id?.uuidString else { return }
        // TODO: implement this
        client.deleteIdea(withId: id) { (result) in
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
    
}
