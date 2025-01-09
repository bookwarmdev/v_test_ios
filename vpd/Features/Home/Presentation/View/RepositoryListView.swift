//
//  RepositoryListView.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//


import SwiftUI

struct RepositoryListView: View {
    @StateObject private var viewModel = RepositoryListViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                switch viewModel.listRepoLState {
                case .idle:
                    AppLoader()
                case .loading:
                    AppLoader()
                case .success:
                    ListRepoView()
                case .failure(let error):
                    if (viewModel.repositories.isEmpty) {
                        ErrorView(
                            error: error,
                            onTap: {
                                viewModel.refreshRepositories()
                            }
                        )
                    } else {
                        ListRepoView()
                    }
                    
                }
            }
            .navigationTitle("Repositories")
            .refreshable {
                viewModel.refreshRepositories()
            }
            .onAppear {
                viewModel.loadRepositories(page: viewModel.currentPage)
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(
                    title: Text("\(error.message.title)"),
                    message: Text(error.message.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
