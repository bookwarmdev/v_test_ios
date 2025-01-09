//
//  GitHubEntity+CoreDataProperties.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//
//

import Foundation
import CoreData


extension GitHubEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GitHubEntity> {
        return NSFetchRequest<GitHubEntity>(entityName: "GitHubEntity")
    }
    
    @NSManaged public var avatarUrl: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var fullName: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var ownerLogin: String?
    @NSManaged public var owner: OwnerEntity?
    
}

extension GitHubEntity : Identifiable {
    
}

extension GitHubEntity : Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case descriptions = "description"
        case htmlUrl = "html_url"
        case ownerLogin = "owner_login"
        case avatarUrl = "avatar_url"
        case owner
    }
}
