//
//  UpdateIdeaViewModel.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/10/20.
//

import Foundation
import Utils
import IdeaTrackerAPI

// TODO: store the string as the user writes in the viewmodel
class UpdateIdeaViewModel: CreateIdeaViewModel {
    
    // MARK: - Properties
    
    private var idea: Idea
    
    override var selectedUser: PublicUserData? {
        didSet {
            guard let user = selectedUser else { return }
            idea.userId = user.id
        }
    }
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient, idea: Idea) {
        self.idea = idea
        super.init(client: client)
    }
    
    // MARK: - Methods
    
    override func loadData() {
        onListSuccess?([
            .name(idea.name),
            .description(idea.description),
            .user(idea.userId.uuidString) // show the id while the users load
        ])
        // async load the user (section #2)
        isLoading?(true)
        client.getUsers { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let data):
                    self.users = data
                    data.first(where: { $0.id == self.idea.userId }).map { user in
                        self.selectedUser = user
                        self.onSelectUser?(user.username)
                    }
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
    override func saveIdea(_ name: String, _ description: String) {
        // TODO: add some kind of validation
        // compare original vs modified
        // make sure something changed
//        if name == idea.name && idea.description == description {
//            onCreateIdeaSuccess?(idea)
//            return
//        }
        idea.name = name
        idea.description = description
        client.updateIdea(idea) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success(let idea):
                    self.onCreateIdeaSuccess?(idea)
                case .failure(let error):
                    self.onCreateIdeaFailure?(error)
                }
            }
        }
    }
    
}
