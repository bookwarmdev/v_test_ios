//
//  GithubDataRemoteDataSourceImpl.swift
//  vpd
//
//  Created by Faruk Amoo on 08/01/2025.
//

import Foundation


class GithubRemoteDataSourceImpl: GithubDataSource {

    func fetchGithubRepo(page: Int, size: Int) async throws -> Data {
        return try await NetworkManager.shared.getData(
            url: UrlPaths.getRepos(page: page, size: size)
        )
    }
}
