//
//  LoginViewController.swift
//  Sonder
//
//  Created by Richard Price on 26/07/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseStorage

class LoginViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "addPhoto"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
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
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerUser = CALayer()
        bottomLayerUser.frame = CGRect(x: 0, y: 29, width: 300, height: 0.6)
        bottomLayerUser.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        tf.layer.addSublayer(bottomLayerUser)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.isSecureTextEntry = true
        tf.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedStringKey.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerUser = CALayer()
        bottomLayerUser.frame = CGRect(x: 0, y: 29, width: 300, height: 0.6)
        bottomLayerUser.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 175/255, alpha: 1).cgColor
        tf.layer.addSublayer(bottomLayerUser)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Already have an account?  Sign In.", for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg1"))
        setupUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAlreadyLoggedIn()
    }
    
    fileprivate func checkAlreadyLoggedIn() {
        if Auth.auth().currentUser != nil {
            let controller = MainTabBarController()
            present(controller, animated: true, completion: nil)
        }
    }

    //MARK:- helper functions
    @objc func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSignIn() {
        
       navigationController?.popViewController(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info["UIimagePickerControllerEditedImage"] as? UIImage {
            addPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        } else if let  originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            addPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.isEmpty == false && userNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        
        if isFormValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    @objc fileprivate func handleSignUp() {
        
        guard let email = emailTextField.text, !email.isEmpty else {return}
        guard let username = userNameTextField.text, !username.isEmpty else {return}
        guard let password = passwordTextField.text, !password.isEmpty else {return}

        Auth.auth().createUser(withEmail: email, password: password) { (user, error: Error?) in
            
            if let err = error {
                print("failed to create a user", err)
                return
            }
            print("succesfully created a user in firebase", user?.uid ?? "")
            
            guard let image = self.addPhotoButton.imageView?.image else {return}
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}
            let fileName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference()
            let storageRefChild = storageRef.child("profile_images").child(fileName)
            
            storageRefChild.putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if let err = err {
                    print("unable to add into firebase storage due to err: \(err)")
                    return
                }
                storageRefChild.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print("unable to retrieve url due to error: \(err.localizedDescription)")
                        return
                    }
                    let profilePicUrl = url?.absoluteString
                    print("profile image successfully added into firebase storage with url: \(profilePicUrl ?? "")")
                    
                    guard let uid = user?.uid else {return}
                    let usernameValues = ["username": username, "profilePicUrl": profilePicUrl]
                    let values = [uid: usernameValues]
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if let err =  err {
                            print("failed to add user", err)
                            return
                        }
                        print("success....saved userinfo to DB")
                    })
                })
            })
        }
    }
    
    //MARK:- setup UI
    
    fileprivate func setupUI() {
        
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
        
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        view.addSubview(signUpButton)
        signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        
    }
}

