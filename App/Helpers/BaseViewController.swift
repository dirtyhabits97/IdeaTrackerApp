//
//  BaseViewController.swift
//  IdeaTrackerAppLib
//
//  Created by DIGITAL008 on 10/9/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var errorHandler: ErrorHandler?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupBindings() { }
    
}
