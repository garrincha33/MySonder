//
//  HomeController.swift
//  Sonder
//
//  Created by Richard Price on 22/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePostCellDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "post", style: .plain, target: self, action: #selector(handlePost))
        collectionView?.backgroundColor = UIColor.rgb(red: 38, green: 45, blue: 47)
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: String(describing: HomePostCell.self))
        fetchPosts()
        transparentNavBar()
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: view.frame.width, height: 250)
        var height: CGFloat = 60 + 8 + 8
        height += view.frame.width
        height += 10
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomePostCell.self), for: indexPath) as! HomePostCell
        
        cell.post = posts[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    @objc fileprivate func handlePost() {
        
        print("testing 123")
        
        let controller = ShareUserPost()
        navigationController?.pushViewController(controller, animated: true)

    }

    fileprivate func transparentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func didTapAudioButton() {
        print("testing from homeController")
        let controller = AudioViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //fetch posts
    var posts = [Post]()
    fileprivate func fetchPosts() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = User(dictionary: userDictionary)
            
            let ref = Database.database().reference().child("posts").child(uid)
            ref.observeSingleEvent(of: .value) { (snapshot) in
                guard let dictionaries = snapshot.value as? [String: Any] else {return}
                dictionaries.forEach({ (key, value) in
                    guard let dictionary = value as? [String: Any] else {return}
                    let post = Post(user: user, dictionary: dictionary)
                    self.posts.append(post)
                })
                self.collectionView?.reloadData()
            }
        }
    }
}
