//
//  IdeaTrackerAPI.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import Foundation
import LeanNetworkKit

public struct IdeaTrackerAPI {
    
    private unowned let client: HTTPClient
    private static let token = "qi6IWbrB0m2GeSa3jXHnkw=="
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func getUsers(_ completion: @escaping (Result<[PublicUserData], NKError.RequestError>) -> Void) {
        let request = Request(url: .adminURL, path: "/users", method: .get)
            // TODO: find a better way to get this token
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .decode(to: [PublicUserData].self)
        client.send(request, completion)
    }
    
}

extension URL {
    
    static let adminURL = URL(string: "http://localhost:8080/api/admin")!
    
}
