//
//  MovierContainer.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/2/24.
//

import Swinject

extension Container {
    
    static let container: Container = {
        let container = Container()
        
        container.register(RequestFactoryProtocol.self) { _ in
            RequestFactory()
        }.inObjectScope(.container)
        
        container.register(DataTaskFactoryProtocol.self) { _ in
            DataTaskFactory()
        }.inObjectScope(.container)
        
        container.register(MovieServiceProtocol.self) { resolver in
            MovieService(
                dataTaskFactory: resolver.resolve(DataTaskFactoryProtocol.self)!,
                requestFactory: resolver.resolve(RequestFactoryProtocol.self)!
            )
        }.inObjectScope(.container)
        
        container.register(MovieManagerProtocol.self) { resolver in
            MovieManager(movieService: resolver.resolve(MovieServiceProtocol.self)!)
        }.inObjectScope(.container)
        
        _ = container.resolve(MovieManagerProtocol.self)
        
        return container
    }()
    
}
