//
//  CustomView.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 2.12.20..
//

import UIKit

class CustomView: UIView {

    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 10
    }
    
}
