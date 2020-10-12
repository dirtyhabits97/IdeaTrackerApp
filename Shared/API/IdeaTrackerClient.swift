//
//  IdeaTrackerAPI.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 9/30/20.
//

import Foundation
import LeanNetworkKit

public struct IdeaTrackerClient {
    
    // MARK: - Properties
    
    public static let userTokenStorageKey = "com.gerh.UserTokenStorageKey"
    
    unowned let client: HTTPClient
    
    // MARK: - Lifecycle
    
    public init(client: HTTPClient) {
        self.client = client
    }

    // MARK: - Methods
    
    /**
     This method stores the token in UserDefaults under
     `IdeaTrackerClient.userTokenStorageKey`
     
     - Parameters:
        - username: the username that identifies the user.
        - password: the user's password.
        - completion: the completion block to execute.
     */
    public func logUserIn(
        _ username: String,
        password: String,
        _ completion: @escaping (Result<Void, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .baseURL, path: "/login", method: .post)
            .addAuthorization(username: username, password: password)
            .decode(to: Token.self)
        client.send(request)
            .onSuccess({ (token) in
                UserDefaults.standard.setValue(
                    token.value,
                    forKey: Self.userTokenStorageKey
                )
                completion(.success(()))
            })
            .onFailure({ (error) in
                completion(.failure(error))
            })
    }
    
}

extension URL {
    
    static let baseURL = URL(string: "http://localhost:8080/api")!
    
}

extension Request {
    
    // TODO: add to LeanNetworkKit
    func addAuthorization(username: String, password: String) -> Self {
        let strToEncode = username + ":" + password
        guard let token = strToEncode.data(using: .utf8)?.base64EncodedString() else {
            fatalError("Failed to encode authorization for \(username).")
        }
        return addHeader(key: "Authorization", val: "Basic \(token)")
    }
    
    // TODO: add to LeanNetworkKit
    func addAuthorization(token: String) -> Self {
        addHeader(key: "Authorization", val: "Bearer \(token)")
    }
    
}
