//
//  UserListViewModel.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import IdeaTrackerAPI

class UserListViewModel {
    
    // MARK: - Properties
    
    let client: IdeaTrackerClient
    
    // MARK: - Callbacks
    
    var onSucess: (([PublicUserData]) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient) {
        self.client = client
    }
    
    // MARK: - Methods
    
    func loadData() {
        client.getUsers { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.onSucess?(data)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
}
