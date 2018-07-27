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
    
    let userNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Username",
        attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerUser = CALayer()
        bottomLayerUser.frame = CGRect(x: 0, y: 29, width: 300, height: 0.6)
        bottomLayerUser.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        tf.layer.addSublayer(bottomLayerUser)
        return tf
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg1"))
        
        
        view.addSubview(addPhotoButton)
        addPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addPhotoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        view.addSubview(userNameTextField)
        userNameTextField.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        userNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true

    }
}

