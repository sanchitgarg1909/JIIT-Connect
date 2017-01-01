
import UIKit

class MenuCell: BaseCell{
    
    let label: UILabel = {
        let l = UILabel()
        l.textAlignment = NSTextAlignment.center
        return l
    }()
    
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(label)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: label)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: label)
        
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
