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
        
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupTextContainerView()

    }
    
    fileprivate func setupTextContainerView() {
        
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
    }

}
