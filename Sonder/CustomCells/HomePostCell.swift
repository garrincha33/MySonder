//
//  HomePostCell.swift
//  Sonder
//
//  Created by Richard Price on 22/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            print(post?.user ?? "")
            usernameLable.text = post?.user.username
            setupAttributedCaption()
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let usernameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Username"
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        return lable
        
    }()
    
    let postLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = .white
        lable.layer.cornerRadius = 8
        lable.clipsToBounds = true
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(innerView)
        innerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        addSubview(postLable)
        postLable.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handlePlayAudio() {
        print("test")
    }
    
    fileprivate func setupAttributedCaption() {
        guard let post = self.post else {return}
        
        let attributedText = NSMutableAttributedString(string: post.user.username, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " \(post.caption)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        postLable.attributedText = attributedText
        postLable.numberOfLines = 0
    }
}
