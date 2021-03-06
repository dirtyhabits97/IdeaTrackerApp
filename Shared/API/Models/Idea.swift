//
//  Idea.swift
//  IdeaTrackerApp
//
//  Created by DIGITAL008 on 10/4/20.
//

import Foundation

public struct Idea: Codable {
    
    // MARK: - Properties
    
    public let id: UUID
    public var name: String
    public var description: String
    public var userId: UUID
    
    // MARK: - Encodable
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case description
        // when receiving
        case user
        // when sending
        case userId
        
    }
    
    enum UserKeys: String, CodingKey {
        
        case id
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        let userContainer = try container.nestedContainer(
            keyedBy: UserKeys.self,
            forKey: .user
        )
        userId = try userContainer.decode(UUID.self, forKey: .id)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(userId, forKey: .userId)
    }
    
}
