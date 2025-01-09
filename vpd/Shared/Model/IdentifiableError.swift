//
//  IdentifiableError.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation


struct IdentifiableError: Identifiable {
    let id = UUID() // Unique identifier for each error
    let message: ErrorMessageModel
}
