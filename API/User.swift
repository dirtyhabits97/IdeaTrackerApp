//
//  User.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation

public struct PublicUserData: Codable {
    
    public let id: UUID?
    public let name: String
    public let username: String
    
}

public struct PrivateUserData: Codable {
    
    public let id: UUID?
    public let name: String
    public let username: String
    public let password: String
    
    public init(
        id: UUID? = nil,
        name: String,
        username: String,
        password: String
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
    }
    
}
