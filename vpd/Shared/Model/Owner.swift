//
//  Owner.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//


struct Owner: Decodable {
    let id: Int64
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarUrl = "avatar_url"
    }
}
