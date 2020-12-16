//
//  ButtonShadow.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 23.11.20..
//

import UIKit

class ButtonShadow: UIButton {
    
    override func awakeFromNib() {
            super.awakeFromNib()
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
//            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 2
        }
}
