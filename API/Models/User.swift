//
//  User.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation

public struct PublicUserData: Decodable {
    
    public let id: UUID
    public var name: String
    public var username: String
    
}
