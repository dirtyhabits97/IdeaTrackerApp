//
//  ViewModel.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import Foundation
import IdeaTrackerAPI

class ViewModel {
    
    var isLoading: ((Bool) -> Void)?
    var onFailure: ((Error) -> Void)?
    
    func loadData() { } // override this
    
}

class ListViewModel<Model>: ViewModel {
    
    // MARK: - Properties
    
    let client: IdeaTrackerClient
    
    // MARK: - Callbacks
    
    var onListSuccess: (([Model]) -> Void)?
    var onCreateSuccess: ((Model) -> Void)?
    var onDeleteSuccess: (() -> Void)?
    /// (Index, Model) -> Void
    var onUpdateSuccess: ((Int, Model) -> Void)?
    
    // MARK: - Lifecycle
    
    init(client: IdeaTrackerClient) {
        self.client = client
    }
    
}
