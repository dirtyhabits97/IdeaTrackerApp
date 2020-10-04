//
//  ViewController.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import UIKit
import LeanNetworkKit
import IdeaTrackerAPI

let client = HTTPClient(urlSession: URLSession(configuration: .ephemeral))
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

class ViewController: UIViewController {
    
    let api = IdeaTrackerClient(client: client)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        testAPI()
        let button = UIButton(type: .system)
        button.setTitle("Press me", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(testAPI), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func testAPI() {
        api.getUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
    }

}
