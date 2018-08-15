//
//  MainTabBarController.swift
//  Sonder
//
//  Created by Richard Price on 29/07/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //added nav controller
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let loginController = UserLoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
            }

            return
        }
        
        setupViewControllers()
    }
    
    
    
        func setupViewControllers() {
            
            //home
            let homeController = UIViewController()
            let homeNavController = UINavigationController(rootViewController: homeController)
            homeController.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
            homeController.tabBarItem.selectedImage = #imageLiteral(resourceName: "home_selected")
            
        //profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let profileNavController = UINavigationController(rootViewController: userProfileController)
        profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        profileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
            
        tabBar.tintColor = .black
        viewControllers = [homeNavController, profileNavController]
        
    }
}
