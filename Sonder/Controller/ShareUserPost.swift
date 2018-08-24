//
//  ShareUserPost.swift
//  Sonder
//
//  Created by Richard Price on 24/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class ShareUserPost: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
    }
    
    @objc fileprivate func handleCancelButton() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
