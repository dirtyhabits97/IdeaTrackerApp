//
//  BaseViewController.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import UIKit

// TODO: improve this
public protocol ErrorHandler: AnyObject {
    
    func handleError(_ message: String)
    
}

open class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    public weak var errorHandler: ErrorHandler?
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    open func setupView() {
        view.backgroundColor = .white
    }
    
    open func setupBindings() { }
    
}
