//
//  LoginViewModel.swift
//  AdminIdeaTracker
//
//  Created by DIGITAL008 on 10/11/20.
//

import Foundation
import IdeaTrackerAPI
import Utils

class LoginViewModel: ViewModel {
    
    // MARK: - Properties
    
    let client: IdeaTrackerClient
    
    // MARK: - Callbacks
    
    var onSuccess: (() -> Void)?
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient) {
        self.client = client
    }
    
    // MARK: - Methods
    
    func logUserIn(_ username: String, password: String) {
        isLoading?(true)
        client.logUserIn(username, password: password) { (result) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.isLoading?(false)
                switch result {
                case .success:
                    self.onSuccess?()
                case .failure(let error):
                    self.onFailure?(error)
                }
            }
        }
    }
    
}
