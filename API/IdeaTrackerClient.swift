//
//  IdeaTrackerAPI.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import Foundation
import LeanNetworkKit

public struct IdeaTrackerClient {
    
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
    
    public func createUser(
        _ user: PrivateUserData,
        _ completion: @escaping (Result<PublicUserData, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/users", method: .post)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: user)
            .decode(to: PublicUserData.self)
        client.send(request, completion)
    }
    
    public func deleteUser(
        withId id: String,
        _ completion: @escaping (Result<IgnoreResponse, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/users/\(id)", method: .delete)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .ignoreResponse()
        client.send(request, completion)
    }
    
}

extension URL {
    
    static let adminURL = URL(string: "http://localhost:8080/api/admin")!
    
}