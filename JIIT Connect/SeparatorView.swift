//
//  SeperatorView.swift
//  JIIT Connect
//
//  Created by Sanchit Garg on 03/12/16.
//  Copyright © 2016 Sanchit Garg. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
