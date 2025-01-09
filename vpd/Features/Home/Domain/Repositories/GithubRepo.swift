//
//  GithubRepo.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation

protocol GithubRepo {
    func fetchGithubRepo(page: Int, size: Int) async throws -> [GitHubEntity]
}
