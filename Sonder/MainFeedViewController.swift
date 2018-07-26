//
//  MainFeedViewController.swift
//  Sonder
//
//  Created by Richard Price on 26/07/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "addPhoto"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        view.addSubview(addPhotoButton)
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true

    }

 

}

