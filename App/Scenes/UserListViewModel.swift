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
    
    private let client: IdeaTrackerClient
    
    // MARK: - Callbacks
    
    var isLoading: ((Bool) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    var onListSucess: (([PublicUserData]) -> Void)?
    var onCreateSuccess: ((PublicUserData) -> Void)?
    var onDeleteSuccess: (() -> Void)?
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient) {
        self.client = client
    }
    
    // MARK: - Methods
    
    func loadData() {
        isLoading?(true)
        client.getUsers { (result) in
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
    
    func createUser(
        name: String,
        username: String,
        password: String
    ) {
        let data = PrivateUserData(
            name: name,
            username: username,
            password: password
        )
        isLoading?(true)
        client.createUser(data) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let user):
                    self.onCreateSuccess?(user)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
    func deleteUser(withId id: UUID?) {
        guard let id = id?.uuidString else { return }
        isLoading?(true)
        client.deleteUser(withId: id) { (result) in
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
