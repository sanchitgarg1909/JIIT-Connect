
import UIKit

class ClassCell: BaseCell {
    
    var classObject: Class? {
        didSet {
            subjectLabel.text = classObject?.course_name
            roomLabel.text = classObject?.venue
            timeLabel.text = classObject?.time
            if let type = classObject?.type {
                let name: String?
                switch type {
                case "Lecture":
                    name = "lecture"
                    break
                case "Tutorial":
                    name = "tutorial"
                    break
                case "Practical":
                    name = "practical"
                    break
                default:
                    name = "lecture"
                    break
                }
                imageView.image = UIImage(named: name!)
            }
            
//            setupThumbnailImage()
//            
//            setupProfileImage()
            
//            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
//                
//                let numberFormatter = NumberFormatter()
//                numberFormatter.numberStyle = .decimal
//                
//                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago "
//                subtitleTextView.text = subtitleText
//            }
            
            //measure title text
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
            
            
        }
    }
    
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
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
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
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 2
        return label
    }()
    
    let roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.numberOfLines = 2
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
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
        
        
        let margins = self.layoutMarginsGuide

        imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        subjectLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        subjectLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
        subjectLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -16).isActive = true
        subjectLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        roomLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 16).isActive = true
        roomLabel.leadingAnchor.constraint(equalTo: subjectLabel.leadingAnchor, constant: 0).isActive = true
        roomLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        roomLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        timeLabel.topAnchor.constraint(equalTo: roomLabel.topAnchor, constant: 0).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: subjectLabel.rightAnchor, constant: 0).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        separatorView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
    }
    
}
