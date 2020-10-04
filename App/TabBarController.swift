//
//  TabBarController.swift
//  app-lib
//
//  Created by DIGITAL008 on 10/4/20.
//

import UIKit
import LeanNetworkKit
import IdeaTrackerAPI

class TabBarController: UITabBarController {

    let client = IdeaTrackerClient(client: httpClient)
    
    // MARK: - UI elements
    
    lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Oops", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        // users controller
        let userListViewController = UserListViewController()
        userListViewController.errorHandler = self
        userListViewController.viewModel = UserListViewModel(client: client)
        let userListNavController = UINavigationController(rootViewController: userListViewController)
        userListNavController.navigationBar.prefersLargeTitles = true
        userListNavController.tabBarItem.title = "Users"
        // ideas controller
        let ideaListViewController = IdeaListViewController()
        ideaListViewController.errorHandler = self
        ideaListViewController.viewModel = IdeaListViewModel(client: client)
        let ideaListNavController = UINavigationController(rootViewController: ideaListViewController)
        ideaListNavController.navigationBar.prefersLargeTitles = true
        ideaListNavController.tabBarItem.title = "Ideas"
        // set the viewcontrollers
        viewControllers = [
            userListNavController,
            ideaListNavController
        ]
    }
    
}

// MARK: - Error handling

extension TabBarController: ErrorHandler {
    
    func handleError(_ message: String) {
        present(errorAlert, animated: true, completion: nil)
    }
    
}

// MARK: Network configuration

let httpClient = HTTPClient(urlSession: URLSession(configuration: .ephemeral))
    .observeRequests(requestWillLoad: { (request) in
        var str = request.httpMethod?.uppercased() ?? "-"
        str += "\t"
        str += request.url?.absoluteString ?? "-"
        str += "\n"
        for (key, val) in request.allHTTPHeaderFields ?? [:] {
            str += "\t\(key):\t\(val)\n"
        }
        print(str)
    }, requestDidLoad: { (req, res, data) in
        var str = "Headers: [\n"
        for (key, val) in res.allHeaderFields {
            str += "\t\(key):\t\(val)\n"
        }
        str += "]\n"
        str += "Bytes: \(data?.count ?? 0)"
        print(str)
    }, requestDidSucceed: { (req, _) in
        print("Request did succeed")
    }, requestDidFail: { (req, error) in
        print("Request did fail", error.localizedDescription)
    }, didCancelRequest: { _ in
        print("Request was canceled.")
    })
