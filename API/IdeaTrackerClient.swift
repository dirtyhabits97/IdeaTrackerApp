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
    
    // MARK: - User methods
    
    public func getUsers(_ completion: @escaping (Result<[PublicUserData], NKError.RequestError>) -> Void) {
        let request = Request(url: .adminURL, path: "/users", method: .get)
            // TODO: find a better way to get this token
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .decode(to: [PublicUserData].self)
        client.send(request, completion)
    }
    
    public func createUser(
        _ name: String,
        username: String,
        password: String,
        _ completion: @escaping (Result<PublicUserData, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/users", method: .post)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: CreateUser(
                name: name,
                username: username,
                password: password
            ))
            .decode(to: PublicUserData.self)
        client.send(request, completion)
    }
    
    public func deleteUser(
        withId id: UUID,
        _ completion: @escaping (Result<IgnoreResponse, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/users/\(id.uuidString)", method: .delete)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .ignoreResponse()
        client.send(request, completion)
    }
    
    public func updateUser(
        _ user: PublicUserData,
        password: String,
        _ completion: @escaping (Result<PublicUserData, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/users/\(user.id.uuidString)", method: .put)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: CreateUser(
                id: user.id,
                name: user.name,
                username: user.username,
                password: password
            ))
            .decode(to: PublicUserData.self)
        client.send(request, completion)
    }
    
    // MARK: - Idea methods
    
    public func getIdeas(_ completion: @escaping (Result<[Idea], NKError.RequestError>) -> Void) {
        let request = Request(url: .adminURL, path: "/ideas", method: .get)
            // TODO: find a better way to get this token
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .decode(to: [Idea].self)
        client.send(request, completion)
    }
    
    // TODO: make this return an idea, so it can be appended
    public func createIdea(
        _ name: String,
        description: String,
        userId: UUID,
        _ completion: @escaping (Result<Idea, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/ideas", method: .post)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: CreateIdea(
                name: name,
                description: description,
                userId: userId
            ))
            .decode(to: Idea.self)
        client.send(request, completion)
    }
    
    public func deleteIdea(
        withId id: UUID,
        _ completion: @escaping (Result<IgnoreResponse, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/ideas/\(id.uuidString)", method: .delete)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .ignoreResponse()
        client.send(request, completion)
    }
    
    public func updateIdea(
        _ idea: Idea,
        _ completion: @escaping (Result<Idea, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/ideas/\(idea.id.uuidString)", method: .put)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: idea)
            .decode(to: Idea.self)
        client.send(request, completion)
    }
    
    // MARK: - Category methods
    
    public func getCategories(_ completion: @escaping (Result<[IdeaCategory], NKError.RequestError>) -> Void) {
        let request = Request(url: .adminURL, path: "/categories", method: .get)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .decode(to: [IdeaCategory].self)
        client.send(request, completion)
    }
    
    public func createCategory(
        _ name: String,
        _ completion: @escaping (Result<IdeaCategory, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/categories", method: .post)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: CreateCategory(name: name))
            .decode(to: IdeaCategory.self)
        client.send(request, completion)
    }
    
    public func deleteCategory(
        withId id: UUID,
        _ completion: @escaping (Result<IgnoreResponse, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/categories/\(id.uuidString)", method: .delete)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .ignoreResponse()
        client.send(request, completion)
    }
    
    public func updateCategory(
        _ category: IdeaCategory,
        _ completion: @escaping (Result<IdeaCategory, NKError.RequestError>) -> Void
    ) {
        let request = Request(url: .adminURL, path: "/categories/\(category.id.uuidString)", method: .put)
            .addHeader(key: "Authorization", val: "Bearer 9ysy0fEa7oZTlCEGONiAZA==")
            .addHeader(key: "Content-Type", val: "application/json")
            .setBody(fromObject: category)
            .decode(to: IdeaCategory.self)
        client.send(request, completion)
    }
    
}

extension URL {
    
    static let adminURL = URL(string: "http://localhost:8080/api/admin")!
    
}

private struct CreateIdea: Encodable {
    
    let name: String
    let description: String
    let userId: UUID
    
}

private struct CreateUser: Encodable {
    
    let id: UUID?
    let name: String
    let username: String
    let password: String
    
    init(
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

private struct CreateCategory: Encodable {
    
    let name: String
    
}
