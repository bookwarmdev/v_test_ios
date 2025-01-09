//
//  RepositoryListViewModel.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//


import Foundation
import CoreData
import Combine
import SwiftUI


@MainActor
class RepositoryListViewModel: ObservableObject {
    
    let gitHubService = AppDependencies.shared.resolve(GithubRepo.self)

    
    @Published var repositories: [GitHubEntity] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    @Published var hasMoreData: Bool = true
    @Published var errorMessage: IdentifiableError? = nil
    @Published var listRepoLState: LoadingState = .idle
//    @Published var errorMessage: String? = nil

    private var cancellables: Set<AnyCancellable> = []
    private let context = PersistenceController.shared.context
    
    init() {
        loadRepositories(page: currentPage)
    }
    
    func loadRepositories(page: Int) {
        // Check for cached repositories in Core Data
        fetchRepositoriesFromCoreData()

        // Fetch from network if not already loaded
        guard !isLoading else { return }
        guard hasMoreData else { return }

        // Set isPaginationLoading to true when loading more data
        if page > currentPage {
            listRepoLState = .loading
        } else {
            isLoading = true
        }

        Task { [weak self] in
//            self?.listRepoLState = .loading
            do {
                // Perform network request using async/await
                let response = try await self?.gitHubService?.fetchGithubRepo(page: page, size: 10)

                self?.listRepoLState = .success

                guard let newRepositories = response else {
                    // Handle case where no data was returned
                    self?.hasMoreData = false
                    return
                }

                // Append new repositories to the existing list
                DispatchQueue.main.async {
                    self?.repositories.append(contentsOf: newRepositories)
                    if newRepositories.isEmpty {
                        self?.hasMoreData = false
                    } else {
                        self?.currentPage += 1
                    }
                    self?.isLoading = false
                }

                // Save to Core Data (also ensure it's done on the main thread if necessary)
                Task {
                    self?.saveRepositoriesToCoreData(newRepositories)
                }

            } catch {
                DispatchQueue.main.async {
                    let errorMessage = (error as? ErrorMessageModel)?.message ?? "Unknown error"
                    self?.errorMessage = IdentifiableError(message: error as! ErrorMessageModel)
                    self?.isLoading = false
                    self?.listRepoLState = .failure(errorMessage)
                }
                print("Error: \(error.localizedDescription)")
            }
        }
    }


    

    func fetchRepositoriesFromCoreData() {
        let fetchRequest: NSFetchRequest<GitHubEntity> = GitHubEntity.fetchRequest()
       
        do {
            let cachedRepositories = try context.fetch(fetchRequest)
            
            self.repositories = cachedRepositories
            
        } catch {
            print("Error fetching repositories from Core Data: \(error.localizedDescription)")
        }
    }
    
    func saveRepositoriesToCoreData(_ repositories: [GitHubEntity]) {
        for repository in repositories {
            let repo = GitHubEntity(context: context)
            repo.id = Int64(repository.id)
            repo.name = repository.name
            repo.fullName = repository.fullName
            repo.descriptions = repository.description
            repo.htmlUrl = repository.htmlUrl
            repo.ownerLogin = repository.ownerLogin
            repo.avatarUrl = repository.avatarUrl
            
            let ownerEntity = OwnerEntity(context: context)
            ownerEntity.avatarUrl = repository.owner?.avatarUrl
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving repositories to Core Data: \(error.localizedDescription)")
        }
    }
    
    func refreshRepositories() {
        repositories.removeAll()
        currentPage = 1
        hasMoreData = true
        loadRepositories(page: currentPage)
    }
}
