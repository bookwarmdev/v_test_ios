//
//  Paths.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation

class UrlPaths {
    
    static func getRepos(page: Int, size: Int) -> String {
        return "https://api.github.com/users/bookwarmdev/repos?page=\(page)&per_page=\(size)"
    }
    
}
