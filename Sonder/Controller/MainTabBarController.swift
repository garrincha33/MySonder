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
            
            //home controller
            let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"))
            
            //search controller
            let searchNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"))
            
            //camera controller
            let plusNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"))
            
            //like controller
            let likeNavcontroller = templateNavController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"))
            
        //profile
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let profileNavController = UINavigationController(rootViewController: userProfileController)
        profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        profileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
            
        tabBar.tintColor = .black
        viewControllers = [homeNavController, searchNavController, plusNavController, likeNavcontroller,  profileNavController]
        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
