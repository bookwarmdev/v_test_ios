//
//  RepositoryDetailView.swift
//  vpd
//
//  Created by Faruk Amoo on 07/01/2025.
//


import SwiftUI

struct RepositoryDetailView: View {
    var repository: GitHubEntity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Full Name: \(repository.fullName ?? "")")
                    .font(.title2)
                if let description = repository.descriptions {
                    Text("Description: \(description)")
                        .font(.body)
                } else {
                    Text("No description available.")
                        .font(.body)
                        .foregroundColor(.gray)
                }

                Link(
                    "View on GitHub",
                    destination: URL(string: repository.htmlUrl ?? "")!
                )
                .foregroundColor(.blue)
            }
            .padding()
        }
        .navigationTitle(repository.name ?? "")
    }
}
