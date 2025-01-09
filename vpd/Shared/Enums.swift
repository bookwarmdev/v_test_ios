//
//  Enums.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation


enum LoadingState {
    case idle
    case loading
    case success
    case failure(String) // Error message
}
