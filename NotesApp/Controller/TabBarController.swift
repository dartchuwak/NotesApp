//
//  TabBarController.swift
//  NotesApp
//
//  Created by Evgenii Mikhailov on 03.02.2023.
//

import UIKit


class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createNavigationController(viewController: NotesListViewController(), title: "Notes", image: "note"),
                           createNavigationController(viewController: SettingsViewController(), title: "Settings", image: "gear"),
                           ]
    }
    
    
    fileprivate func createNavigationController( viewController: UIViewController, title: String , image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = false
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        navController.navigationBar.backgroundColor = .white
        return navController
    }
}
