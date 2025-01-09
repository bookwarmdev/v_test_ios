//
//  GithubRepoImpl.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//

import Foundation


class GithubRepoImpl: GithubRepo {
    func fetchGithubRepo(page: Int, size: Int) async throws -> [GitHubEntity] {
        let data =  try await remoteDataSource.fetchGithubRepo(page: page, size: size)
        
        
        let decodedResponse = try await NetworkManager.shared.parseResponse(data, type: [GitHubEntity].self)
        
        return decodedResponse
    }
    
    private let remoteDataSource: GithubDataSource
    
    init(remoteDataSource: GithubRemoteDataSourceImpl) {
        self.remoteDataSource = remoteDataSource
    }
}

