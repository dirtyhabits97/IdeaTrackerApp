//
//  UserListViewModel.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation
import Utils
import IdeaTrackerAPI

class UserListViewModel: ListViewModel<PublicUserData> {
    
    // MARK: - Methods
    
    override func loadData() {
        isLoading?(true)
        client.getUsers { (result) in
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
    
    func createUser(
        name: String,
        username: String,
        password: String
    ) {
        isLoading?(true)
        client.createUser(
            name,
            username: username,
            password: password
        ) { (result) in
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
    
    func deleteUser(withId id: UUID) {
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
    
    func updateUser(
        _ user: PublicUserData,
        password: String,
        at index: Int
    ) {
        isLoading?(true)
        client.updateUser(user, password: password) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let user):
                    self.onUpdateSuccess?(index, user)
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
}
