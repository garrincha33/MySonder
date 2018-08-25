//
//  ShareUserPost.swift
//  Sonder
//
//  Created by Richard Price on 24/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ShareUserPost: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupTextContainerView()

    }
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .white
        return tv
    }()
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ask Your Question", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handlePost), for: .touchUpInside)
        button.isEnabled = true
        return button
    }()

    fileprivate func setupTextContainerView() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 3.0
        containerView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        containerView.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor

        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        view.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 150)
        view.addSubview(postButton)
        postButton.anchor(top: textView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
    }
    
    @objc fileprivate func handlePost() {

        guard let captionText = textView.text, !captionText.isEmpty else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let caption = textView.text else {return}
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["caption": caption, "creationDate": Date().timeIntervalSince1970] as [String: Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("unable to save post to db", err)
                return
            }
            print("sucessfully saved post to DB")
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
}
