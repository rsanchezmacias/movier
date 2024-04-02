//
//  MainViewController.swift
//  Movier
//
//  Created by Ricardo Sanchez-Macias on 4/1/24.
//

import UIKit

enum ApplicationTab: Int, CaseIterable {
    case movie
    case search
    case account
    
    var viewController: String? {
        switch self {
        case .movie:
            return MovieStackViewController.name
        case .search, .account:
            return nil
        }
    }
    
    var image: String {
        switch self {
        case .movie:
            return "movieclapper"
        case .search:
            return "magnifyingglass"
        case .account:
            return "person.crop.circle"
        }
    }
}

class MainViewController: UIViewController {
    
    static let name: String = "MainViewController"
    
    private var tabController: UITabBarController!
    
    private var navigationControllers: [UINavigationController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initChildControllers()
        setupTab()
    }
    
    private func initChildControllers() {
        ApplicationTab.allCases.forEach { tab in
            var viewController: UIViewController = UIViewController()
            if let name = tab.viewController {
                let storyboard = UIStoryboard(name: name, bundle: nil)
                viewController = storyboard.instantiateInitialViewController() ?? UIViewController()
            }
            
            let navigationController = UINavigationController(rootViewController: viewController)
            let tabBarItem = UITabBarItem(title: nil, image:  UIImage(systemName: tab.image), tag: tab.rawValue)
            tabBarItem.image = UIImage(systemName: tab.image)?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
            tabBarItem.selectedImage = UIImage(systemName: tab.image)?.withTintColor(.black, renderingMode: .alwaysOriginal)
            navigationController.tabBarItem = tabBarItem
            
            navigationControllers.append(navigationController)
        }
    }
    
    private func setupTab() {
        tabController = UITabBarController()
        tabController.viewControllers = navigationControllers
        tabController.selectedViewController = navigationControllers[0]
        tabController.tabBar.isTranslucent = false
        tabController.tabBar.backgroundImage = nil
        
        self.addChild(tabController)
        self.view.addSubview(tabController.view)
        tabController.view.translatesAutoresizingMaskIntoConstraints = false
        tabController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tabController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tabController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tabController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        addSeparator()
        self.tabController.didMove(toParent: self)
    }
    
    private func addSeparator() {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        
        self.view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.leadingAnchor.constraint(equalTo: tabController.tabBar.leadingAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: tabController.tabBar.topAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: tabController.tabBar.trailingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}

