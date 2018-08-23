//
//  HomePostCell.swift
//  Sonder
//
//  Created by Richard Price on 22/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let postLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = .yellow
        return lable
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(postLable)
        postLable.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: -10, paddingRight: 10, width: 0, height: 0)
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: -20, paddingRight: 20, width: 150, height: 100)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func handlePlayAudio() {
        print("test")
    }
}
