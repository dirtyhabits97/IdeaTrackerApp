//
//  AppDelegate.swift
//  IdeaTracker
//
//  Created by DIGITAL008 on 10/11/20.
//

import UIKit
import LeanNetworkKit
import IdeaTrackerAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let client = IdeaTrackerClient(client: httpClient)

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        // 1. check if the token exists
        if UserDefaults.standard.string(forKey: IdeaTrackerClient.userTokenStorageKey) != nil {
            window.rootViewController = GreetingsViewController()
        } else {
            let rootViewController = LoginViewController()
            rootViewController.viewModel = LoginViewModel(client: client)
            window.rootViewController = rootViewController
        }
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

let httpClient = HTTPClient(urlSession: URLSession(configuration: .ephemeral))
    .observeRequests(requestWillLoad: { (request) in
        var str = "⬆️\t" + (request.httpMethod?.uppercased() ?? "-")
        str += "\t"
        str += request.url?.absoluteString ?? "-"
        str += "\n"
        str += "Headers: [\n"
        for (key, val) in request.allHTTPHeaderFields ?? [:] {
            str += "\t\(key):\t\(val)\n"
        }
        str += "]"
        print(str)
    }, requestDidLoad: { (req, res, data) in
        var str = "⬇️\t" + (req.httpMethod?.uppercased() ?? "-")
        str += "\t\(req.url?.absoluteString ?? "-")"
        str += "\t\(res.statusCode)\n"
        str += "Headers: [\n"
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
    .setModifier(AuthorizationModifier())

struct AuthorizationModifier: RequestModifier {
    
    func modify(_ request: inout URLRequest) {
        // make sure there is no authorizatio nset
        guard request.allHTTPHeaderFields?["Authorization"] == nil else { return }
        // get the token
        guard let token = UserDefaults.standard.string(forKey: IdeaTrackerClient.userTokenStorageKey) else {
            return
        }
        // add the auth header
        request.addValue("Authorization", forHTTPHeaderField: "Bearer \(token)")
    }
    
}
