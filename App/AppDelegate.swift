//
//  AppDelegate.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import UIKit
import LeanNetworkKit
import IdeaTrackerAPI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow()
        let viewController = ViewController()
        viewController.viewModel = UserListViewModel(client: client)
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

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

let client = IdeaTrackerClient(client: httpClient)
