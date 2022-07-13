//
//  AppStartConfigurator.swift
//  Lite_iTunes
//
//  Created by Eduard on 25.08.2021.
//

import UIKit

@available(iOS 13.0, *)
final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let searchAppAsRootVC = SearchAppBuilder.build()
        searchAppAsRootVC.navigationItem.title = "Search apps via iTunes"
        
        let searchSongsAsSecondVC = SearchSongsBuilder.build()
        searchSongsAsSecondVC.navigationItem.title = "Search songs via iTunes"
        
        let navAppVC = self.configuredNavigationControllerForApp
        navAppVC.viewControllers = [searchAppAsRootVC]
        navAppVC.title = "Search applications"
        
        let navSongsVC = self.configuredNavigationControllerForSongs
        navSongsVC.viewControllers = [searchSongsAsSecondVC]
        navSongsVC.title = "Search songs"
        
        let tabBarVC = self.configuredTabBarController
        tabBarVC.setViewControllers([navAppVC, navSongsVC], animated: false)
        tabBarVC.tabBar.items![0].image = UIImage(systemName: "app")
        tabBarVC.tabBar.items![1].image = UIImage(systemName: "music.note.list")
        
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredTabBarController: UITabBarController = {
        let tabBarVC = UITabBarController()
        tabBarVC.modalPresentationStyle = .fullScreen
        return tabBarVC
    }()
    
    
    private lazy var configuredNavigationControllerForApp: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
    
    private lazy var configuredNavigationControllerForSongs: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}


