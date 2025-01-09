//
//  OwnerEntity+CoreDataProperties.swift
//  vpd
//
//  Created by Faruk Amoo on 08/01/2025.
//
//

import Foundation
import CoreData


extension OwnerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OwnerEntity> {
        return NSFetchRequest<OwnerEntity>(entityName: "OwnerEntity")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var id: Int64
    @NSManaged public var owner: GitHubEntity?

}

extension OwnerEntity : Identifiable {

}
