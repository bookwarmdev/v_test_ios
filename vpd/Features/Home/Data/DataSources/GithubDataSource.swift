//
//  GithubDataSource.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation


protocol GithubDataSource {
    func fetchGithubRepo(page: Int, size: Int) async throws -> Data
}
