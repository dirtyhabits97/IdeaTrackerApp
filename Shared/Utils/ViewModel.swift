//
//  ViewModel.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import Foundation
import IdeaTrackerAPI

open class ViewModel {
    
    public var isLoading: ((Bool) -> Void)?
    public var onFailure: ((Error) -> Void)?
    
    public init() { }
    
    open func loadData() { } // override this
    
}

open class ListViewModel<Model>: ViewModel {
    
    // MARK: - Properties
    
    public let client: IdeaTrackerClient
    
    // MARK: - Callbacks
    
    public var onListSuccess: (([Model]) -> Void)?
    public var onCreateSuccess: ((Model) -> Void)?
    public var onDeleteSuccess: (() -> Void)?
    /// (Index, Model) -> Void
    public var onUpdateSuccess: ((Int, Model) -> Void)?
    
    // MARK: - Lifecycle
    
    public init(client: IdeaTrackerClient) {
        self.client = client
    }
    
}
