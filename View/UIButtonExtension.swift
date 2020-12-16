//
//  UIButtonExtension.swift
//  SerbiaQuiz
//
//  Created by Milos Petrusic on 12/11/2020.
//

import UIKit

extension UIButton {
    
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
        
    }
    
    func pulsate() {
        
        let pulsate = CASpringAnimation(keyPath: "transform.scale")
        pulsate.duration = 0.3
        pulsate.fromValue = 0.95
        pulsate.toValue = 1
        pulsate.autoreverses = true
        pulsate.initialVelocity = 0.6
        pulsate.damping = 1.0
        
        layer.add(pulsate, forKey: nil)
        
    }
    
    func pulse() {
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1.0
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = NSNumber(value: 1.1)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        layer.add(pulseAnimation, forKey: nil)
    }
    
}

