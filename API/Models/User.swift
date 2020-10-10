//
//  User.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation

public struct PublicUserData: Decodable {
    
    public let id: UUID
    public let name: String
    public let username: String
    
}
