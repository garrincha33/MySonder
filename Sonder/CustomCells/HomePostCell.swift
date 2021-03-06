//
//  HomePostCell.swift
//  Sonder
//
//  Created by Richard Price on 22/08/2018.
//  Copyright © 2018 twisted echo. All rights reserved.
//

import UIKit

protocol HomePostCellDelegate {
    func didTapAudioButton()
}

class HomePostCell: UICollectionViewCell {
    
    var delegate: HomePostCellDelegate?
    
    var post: Post? {
        didSet {
            print(post?.user ?? "")
            usernameLable.text = post?.user.username
            guard let profileImageUrl = post?.user.profileImageUrl else {return}
            userProfileImageView.loadImage(urlString: profileImageUrl)
            setupAttributedCaption()
        }
    }
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        return iv
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 40, green: 50, blue: 55)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowColor = UIColor.rgb(red: 51, green: 212, blue: 128).cgColor
        view.layer.cornerRadius = 16
        return view
    }()

    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 40, green: 50, blue: 55)
        return view
    }()

    let usernameLable: UILabel = {
        let lable = UILabel()
        lable.text = "Username"
        lable.font = UIFont.boldSystemFont(ofSize: 14)
        lable.textColor = UIColor.rgb(red: 200, green: 201, blue: 202)
        return lable
        
    }()
    
    let postLable: UILabel = {
        let lable = UILabel()
        lable.backgroundColor = UIColor.rgb(red: 40, green: 50, blue: 55)
        lable.textColor = UIColor.rgb(red: 180, green: 182, blue: 183)
        return lable
    }()
    
    lazy var audioRecord: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "audioRecord").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlePostAudio), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubview(userProfileImageView)
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(usernameLable)
        usernameLable.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: userProfileImageView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(postLable)
        postLable.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        postLable.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setupActionButtons()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [audioRecord])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        addSubview(stackView)
        stackView.anchor(top: postLable.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: -10, paddingLeft: -40, paddingBottom: 0, paddingRight: 0, width: 150, height: 50)
    }
    
    @objc fileprivate func handlePlayAudio() {
        print("test")
    }
    
    fileprivate func setupAttributedCaption() {
        guard let post = self.post else {return}
        
        let attributedText = NSMutableAttributedString(string: " \(post.caption)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
//        attributedText.append(NSAttributedString(string: " is asking... \(post.caption)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        attributedText.append(NSAttributedString(string: "\n\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 8)]))
        
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        postLable.attributedText = attributedText
        postLable.numberOfLines = 0
    }
    
    @objc fileprivate func handlePostAudio() {
        delegate?.didTapAudioButton()
    }
}
