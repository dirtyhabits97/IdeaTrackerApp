//
//  CreateIdeaViewModel.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/7/20.
//

import Foundation
import IdeaTrackerAPI

class ViewModel {
    
    var isLoading: ((Bool) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    func loadData() { } // override this
    
}

class CreateIdeaViewModel: ViewModel {
    
    // MARK: - Properties
    
    private let client: IdeaTrackerClient
    
    private(set) var users: [PublicUserData] = []
    private(set) var selectedUser: PublicUserData?
    
    // MARK: - Callbacks
    
    var onSelectUser: (() -> Void)?
    var onSaveUserSuccess: (() -> Void)?
    // special fail case
    var onSaveUserFailure: ((Error) -> Void)?
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient) {
        self.client = client
    }
    
    // MARK: - Methods
    
    override func loadData() {
        isLoading?(true)
        client.getUsers { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let data):
                    self.users = data
                    data.first.map { user in
                        self.selectedUser = user
                        self.onSelectUser?()
                    }
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
    func saveIdea(_ name: String, _ description: String) {
        guard let userId = selectedUser?.id else { return }
        client.saveIdea(
            name,
            description: description,
            userId: userId
        ) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success:
                    self.onSaveUserSuccess?()
                case .failure(let error):
                    self.onSaveUserFailure?(error)
                }
            }
        }
    }
    
    func setUser(_ user: PublicUserData) {
        self.selectedUser = user
        self.onSelectUser?()
    }
    
}
