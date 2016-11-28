//
//  VideoCell.swift
//  Youtube
//
//  Created by Sanchit Garg on 24/11/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import UIKit

class ClassCell: BaseCell {
    
//    var video: Video? {
//        didSet {
//            titleLabel.text = video?.title
//            
//            setupThumbnailImage()
//            
//            setupProfileImage()
//            
//            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
//                
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                
//                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago "
//                subtitleTextView.text = subtitleText
//            }
//            
//            //measure title text
//            if let title = video?.title {
//                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16,height: 1000)
//                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
//                
//                if estimatedRect.size.height > 20 {
//                    titleLabelHeightConstraint?.constant = 44
//                } else {
//                    titleLabelHeightConstraint?.constant = 20
//                }
//            }
//            
//            
//        }
//    }
    
//    func setupProfileImage() {
//        if let profileImageUrl = video?.channel?.profileImageName {
//            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
//        }
//    }
//    
//    func setupThumbnailImage() {
//        if let thumbnailImageUrl = video?.thumbnailImageName {
//            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
//        }
//    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "taylor_swift_profile_picture")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
//    let userProfileImageView: UIImageView = {
//        let imageView = CustomImageView()
//        imageView.layer.cornerRadius = 22
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return view
    }()
    
    let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Artificial Intelligence"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 2
        return label
    }()
    
    let roomLabel: UILabel = {
        let label = UILabel()
        label.text = "G1"
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.numberOfLines = 2
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "9:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.numberOfLines = 2
        return label
    }()
    
    override func setupViews() {
        addSubview(imageView)
        addSubview(subjectLabel)
        addSubview(roomLabel)
        addSubview(timeLabel)
        addSubview(separatorView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(50)]|", views: imageView,subjectLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
//
////        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView)
//        
//        //vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0(50)]-26-[v1(1)]|", views: imageView, separatorView)
        
//        let margins = layoutMarginsGuide
        
//        imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16).isActive = true
//        imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
//        imageView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 16).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        subjectLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        subjectLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16).isActive = true
        subjectLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        subjectLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        roomLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 16).isActive = true
        roomLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        roomLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        roomLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 16).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: subjectLabel.rightAnchor, constant: 0).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //top constraint
//        addConstraint(NSLayoutConstraint(item: roomLabel, attribute: .top, relatedBy: .equal, toItem: subjectLabel, attribute: .bottom, multiplier: 1, constant: 8))
//        //left constraint
//        addConstraint(NSLayoutConstraint(item: roomLabel, attribute: .left, relatedBy: .equal, toItem: imageView, attribute: .right, multiplier: 1, constant: 8))
//        //right constraint
//        addConstraint(NSLayoutConstraint(item: roomLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 0, constant: 50))
//        //height constraint
////        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
//        addConstraint(NSLayoutConstraint(item: roomLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
//        //top constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
//        //left constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
//        //right constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
//        //height constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    
}
