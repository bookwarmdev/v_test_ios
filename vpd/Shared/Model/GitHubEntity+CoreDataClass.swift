//
//  GitHubEntity+CoreDataClass.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//
//

import Foundation
import CoreData

@objc(GitHubEntity)
public class GitHubEntity: NSManagedObject {

    public required convenience init(from decoder: Decoder) throws {
            let context = PersistenceController.shared.container.viewContext
            self.init(context: context)

            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Decode 'id' as Int64 (or Int, depending on your needs)
            id = try container.decode(Int64.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
            fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
            descriptions = try container.decodeIfPresent(String.self, forKey: .descriptions)
            htmlUrl = try container.decodeIfPresent(String.self, forKey: .htmlUrl)
            ownerLogin = try container.decodeIfPresent(String.self, forKey: .ownerLogin) ?? ""
            avatarUrl = try container.decodeIfPresent(String.self, forKey: .avatarUrl)

            // Decode the 'owner' field from the nested dictionary
        if let ownerData = try container.decodeIfPresent(Owner.self, forKey: .owner) {
                let ownerEntity = OwnerEntity(context: context)
                ownerEntity.id = ownerData.id
                ownerEntity.avatarUrl = ownerData.avatarUrl 
                
                // Assign the owner to the GitHubEntity
                self.owner = ownerEntity
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(id, forKey: .id)
            try container.encodeIfPresent(name, forKey: .name)
            try container.encodeIfPresent(fullName, forKey: .fullName)
            try container.encodeIfPresent(descriptions, forKey: .descriptions)
            try container.encodeIfPresent(htmlUrl, forKey: .htmlUrl)
            try container.encodeIfPresent(ownerLogin, forKey: .ownerLogin)
            try container.encodeIfPresent(avatarUrl, forKey: .avatarUrl)
            
            if let ownerEntity = owner {
                var ownerContainer = container.nestedContainer(keyedBy: Owner.CodingKeys.self, forKey: .owner)
                try ownerContainer.encodeIfPresent(ownerEntity.avatarUrl, forKey: .avatarUrl)
            }
        }
    
}


