//
//  PostFeedsCell.swift
//  SocialApp
//
//  Created by VLADISLAV TAIURSKIY on 23.06.16.
//  Copyright © 2016 Vladislav Taiurskiy. All rights reserved.
//

import UIKit

class PostFeedsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let topBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(218, green: 218, blue: 218)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    let userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zuckprofile")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marc Z."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let date = UILabel()
        date.text = "10.01.2016"
        date.font = UIFont.systemFont(ofSize: 12)
        date.textColor = UIColor.gray()
        date.translatesAutoresizingMaskIntoConstraints = false
        
        return date
    }()
    
    let thumbImagePost: UIImageView = {
        let postImage = UIImageView()
        postImage.image = UIImage(named: "image_post_demo")
        postImage.contentMode = .scaleAspectFill
        postImage.layer.masksToBounds = true
        postImage.translatesAutoresizingMaskIntoConstraints = false
        
        return postImage
    }()
    
    let postTitleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 3
        title.text = "Algorithms: The Good, The Bad and The Ugly"
        title.textColor = UIColor.black()
        title.font = UIFont.boldSystemFont(ofSize: 17)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    
    let postDescription : UITextView = {
        let description = UITextView()
        description.text = "Who has been in Free Code Camp without having the experience of spending hours trying to solve Algorithms?"
        description.font = UIFont.systemFont(ofSize: 13)
        description.textColor = UIColor.darkGray()
        description.isEditable = false
        description.isScrollEnabled = false
        description.translatesAutoresizingMaskIntoConstraints = false
        
        return description
    }()
    
    
    func setupViews() {
        backgroundColor = UIColor.white()
        let bottomBorder: UIView
        bottomBorder = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1))
        bottomBorder.backgroundColor = UIColor.rgb(218, green: 218, blue: 218)
        
        addSubview(topBorder)
        addSubview(bottomBorder)
        
        addSubview(userProfileImage)
        addSubview(usernameLabel)
        addSubview(dateLabel)
        addSubview(thumbImagePost)
        addSubview(postTitleLabel)
        addSubview(postDescription)
        
        addConstraintsWithFormat("H:|[v0]|", views: topBorder)
        addConstraintsWithFormat("V:|[v0(1)]", views: topBorder)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbImagePost)
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImage)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: postTitleLabel)
        addConstraintsWithFormat("H:|-14-[v0]-14-|", views: postDescription)
        addConstraintsWithFormat("V:|-16-[v0(44)]", views: userProfileImage)
        
        
        
        /// titleLabel constraints
        // top
        addConstraint(NSLayoutConstraint(item: usernameLabel, attribute: .top, relatedBy: .equal, toItem: userProfileImage, attribute: .top, multiplier: 1, constant: 0))
        // height
        addConstraint(NSLayoutConstraint(item: usernameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        // left
        addConstraint(NSLayoutConstraint(item: usernameLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        // right
        addConstraint(NSLayoutConstraint(item: usernameLabel, attribute: .right, relatedBy: .equal, toItem: thumbImagePost, attribute: .right, multiplier: 1, constant: 0))
        
        /// subTitleTextView constraints
        // top
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: usernameLabel, attribute: .bottom, multiplier: 1, constant: 2))
        // height
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 14))
        // left
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImage, attribute: .right, multiplier: 1, constant: 8))
        // right
        addConstraint(NSLayoutConstraint(item: dateLabel, attribute: .right, relatedBy: .equal, toItem: thumbImagePost, attribute: .right, multiplier: 1, constant: 0))
        
        
        /// thumbImagePost
        addConstraint(NSLayoutConstraint(item: thumbImagePost, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 200))
        
        addConstraint(NSLayoutConstraint(item: thumbImagePost, attribute: .top, relatedBy: .equal, toItem: userProfileImage, attribute: .bottom, multiplier: 1, constant: 22))
        
        /// postTitleLabel
        addConstraint(NSLayoutConstraint(item: postTitleLabel, attribute: .top, relatedBy: .equal, toItem: thumbImagePost, attribute: .bottom, multiplier: 1, constant: 8))
        
        addConstraint(NSLayoutConstraint(item: postTitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 60))
        
        /// postDescription
        addConstraint(NSLayoutConstraint(item: postDescription, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 100))
        
        addConstraint(NSLayoutConstraint(item: postDescription, attribute: .top, relatedBy: .equal, toItem: postTitleLabel, attribute: .bottom, multiplier: 1, constant: 4))
    }
}
