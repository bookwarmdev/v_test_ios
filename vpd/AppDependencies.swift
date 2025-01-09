//
//  AppDependencies.swift
//  Konga
//
//  Created by Amoo .O. Faruk on 13/06/2024.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import SwiftUI


class AppDependencies {
    static let shared = AppDependencies()
    
    private let container: Container
    
    private init() {
        container = Container()
        registerDependencies()
    }
    
    private func registerDependencies() {
                
        // Register your dependencies here
        container.register(GithubRepo.self) { _ in
            GithubRepoImpl(remoteDataSource: GithubRemoteDataSourceImpl())
        }.inObjectScope(.container)
        
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        return container.resolve(type)
    }
}
