//
//  ListRepoView.swift
//  vpd
//
//  Created by Faruk Amoo on 08/01/2025.
//

import SwiftUI

struct ListRepoView: View {
    @StateObject private var viewModel = RepositoryListViewModel()
    @State private var showNoMoreDataMessage: Bool = false
    var body: some View {
        List {
            ForEach(viewModel.repositories.indices, id: \.self) { index in
                let repository = viewModel.repositories[index]
                NavigationLink(
                    destination: RepositoryDetailView(
                        repository: repository
                    )
                ) {
                    HStack {
                        AsyncImage(
                            url: URL(string: repository.owner?.avatarUrl ?? "")
                        ) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            // Placeholder that will show while the image is loading
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .background(Color.red.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 10)  // Padding to the right

                        
                        VStack(alignment: .leading) {
                            
                            Text(repository.name ?? "")
                                .font(.headline)
                            Text(repository.fullName ?? "")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    
                }
                .onAppear {
                    // Load more data when the last item appears
                    if index == viewModel.repositories.count - 1 {
                        viewModel.loadRepositories(page: viewModel.currentPage)
                    }
                    
                    // If we've reached the last item and there's no more data, show the message
                    if !viewModel.hasMoreData {
                        showNoMoreDataMessage = true
                        
                        // Hide the message after 2 seconds
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showNoMoreDataMessage = false
                            }
                        }
                    }
                    
                }
            }
            
            if  showNoMoreDataMessage {
                // Show a message when no repositories are fetched
                HStack {
                    Spacer()
                    Text("No more repositories to load.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
                .transition(.opacity)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
            
        }
    }
}

#Preview {
    ListRepoView()
}
