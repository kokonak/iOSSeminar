//
//  AnimationButton.swift
//  iOS_UI_Seminar
//
//  Created by KOKONAK on 2017. 6. 26..
//  Copyright © 2017년 MyMusicTaste. All rights reserved.
//

import UIKit

class AnimationButton: UIButton {
    fileprivate let arrowLayer: CAShapeLayer = CAShapeLayer()
    fileprivate let topArrowLineLayer: CAShapeLayer = CAShapeLayer()
    fileprivate let bottomArrowLineLayer: CAShapeLayer = CAShapeLayer()
    
    fileprivate let circleLayer: CAGradientLayer = CAGradientLayer()
    fileprivate let circleMaskLayer: CAShapeLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initElements()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initElements()
    }
    
    fileprivate let arrowThickness: CGFloat = 3
    fileprivate let arrowWidth: CGFloat = 15
    
    fileprivate var arrowStartX: CGFloat = 17
    fileprivate var arrowStartY: CGFloat = 17
    
    
    fileprivate func initElements() {
        
        var test: CGFloat = arrowWidth * sqrt(2)/4
        test = test/sqrt(2)
        arrowStartX = (frame.width - arrowWidth)/2 - test-1 + arrowThickness
        arrowStartY = (frame.width - arrowWidth)/2 + test+1 - arrowThickness
        
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
        let arrow: UIBezierPath = UIBezierPath()
        arrow.move(to: CGPoint(x: arrowStartX, y: arrowStartY))
        arrow.addLine(to: CGPoint(x: arrowStartX + arrowWidth, y: arrowStartY))
        arrow.addLine(to: CGPoint(x: arrowStartX + arrowWidth, y: arrowStartY + arrowThickness))
        arrow.addLine(to: CGPoint(x: arrowStartX, y: arrowStartY + arrowThickness))
        arrow.addLine(to: CGPoint(x: arrowStartX, y: arrowStartY))
        arrow.move(to: CGPoint(x: arrowStartX + arrowWidth, y: arrowStartY + arrowThickness))
        arrow.addLine(to: CGPoint(x: arrowStartX + arrowWidth, y: arrowStartY + arrowWidth))
        arrow.addLine(to: CGPoint(x: arrowStartX + arrowWidth - arrowThickness, y: arrowStartY + arrowWidth))
        arrow.addLine(to: CGPoint(x: arrowStartX + arrowWidth - arrowThickness, y: arrowStartY + arrowThickness))
        arrow.addLine(to: CGPoint(x: arrowStartX + arrowWidth, y: arrowStartY + arrowThickness))
        path.append(arrow)
        self.arrowLayer.frame = self.bounds
        self.arrowLayer.path = path.cgPath
        self.arrowLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
        self.arrowLayer.fillColor = UIColor.white.cgColor
        self.arrowLayer.fillRule = kCAFillRuleEvenOdd
        
        self.layer.mask = arrowLayer
        
        self.topArrowLineLayer.frame = CGRect(x: arrowStartX - 1, y: arrowStartY - 1, width: arrowWidth - arrowThickness + 2, height: arrowThickness + 2)
        self.topArrowLineLayer.fillColor = UIColor.red.cgColor
        self.topArrowLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 0, height: arrowThickness + 1)).cgPath
        self.arrowLayer.addSublayer(self.topArrowLineLayer)
        
        self.bottomArrowLineLayer.frame = CGRect(x: arrowStartX + arrowWidth - arrowThickness - 1, y: arrowStartY - 1, width: arrowThickness + 2, height: arrowWidth + 2)
        self.bottomArrowLineLayer.fillColor = UIColor.red.cgColor
        self.bottomArrowLineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: arrowThickness + 2, height: 0)).cgPath
        self.arrowLayer.addSublayer(self.bottomArrowLineLayer)
        
        let diameter: CGFloat = (sqrt(2) * arrowWidth)
        self.circleLayer.frame = CGRect(x: (self.bounds.width - diameter)/2, y: (self.bounds.height - diameter)/2, width: diameter, height: diameter)
        self.circleLayer.colors = [UIColor(red:0.20, green:0.62, blue:0.99, alpha:1.00).cgColor, UIColor(red:0.74, green:0.40, blue:0.83, alpha:1.00).cgColor]
        self.circleLayer.startPoint = CGPoint(x: 0, y: 0)
        self.circleLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.circleMaskLayer.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        self.circleMaskLayer.path = UIBezierPath(roundedRect: CGRect(x: arrowThickness/2, y: arrowThickness/2, width: diameter-arrowThickness, height: diameter-arrowThickness), cornerRadius: diameter/2).cgPath
        self.circleMaskLayer.strokeColor = UIColor(red:0.48, green:0.45, blue:0.88, alpha:1.00).cgColor
        self.circleMaskLayer.lineWidth = arrowThickness
        self.circleMaskLayer.strokeEnd = 0
        self.circleMaskLayer.fillColor = UIColor.clear.cgColor
        self.circleMaskLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
        self.circleLayer.mask = self.circleMaskLayer
        
        self.layer.addSublayer(self.circleLayer)
    }
    
    var duration: Double = 0.10
    func startLoadingAnimation() {
        self.topArrowLineLayer.removeAllAnimations()
        self.bottomArrowLineLayer.removeAllAnimations()
        self.circleMaskLayer.removeAllAnimations()
        
        
        
        let topAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        topAnimation.duration = duration
        topAnimation.fromValue = self.topArrowLineLayer.path
        topAnimation.toValue = UIBezierPath(rect: CGRect(x: 0, y: 0, width: arrowWidth - arrowThickness + 1, height: arrowThickness + 2)).cgPath
        topAnimation.isRemovedOnCompletion = false
        topAnimation.fillMode = kCAFillModeForwards
        topAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.topArrowLineLayer.add(topAnimation, forKey: "topAnimation")
        
        let bottomAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        bottomAnimation.beginTime = CACurrentMediaTime() + duration
        bottomAnimation.duration = duration
        bottomAnimation.toValue = UIBezierPath(rect: CGRect(x: 0, y: 0, width: arrowThickness + 2, height: arrowWidth + 2)).cgPath
        bottomAnimation.fillMode = kCAFillModeForwards
        bottomAnimation.isRemovedOnCompletion = false
        bottomAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.bottomArrowLineLayer.add(bottomAnimation, forKey: "bottomAnimation")
        
        
        let strokeEndAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = duration * 4
        strokeEndAnimation.toValue = 1
        strokeEndAnimation.isRemovedOnCompletion = false
        strokeEndAnimation.fillMode = kCAFillModeForwards
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let strokeStartAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.beginTime = duration * 4
        strokeStartAnimation.duration = duration * 4
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.isRemovedOnCompletion = false
        strokeStartAnimation.fillMode = kCAFillModeForwards
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let groupAnimation: CAAnimationGroup = CAAnimationGroup()
        groupAnimation.animations = [strokeEndAnimation, strokeStartAnimation]
        //        groupAnimation.animations = [strokeEndAnimation]
        groupAnimation.beginTime = CACurrentMediaTime() + duration * 2
        groupAnimation.duration = duration * 8
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.repeatCount = MAXFLOAT
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.circleMaskLayer.add(groupAnimation, forKey: "groupAnimation")
    }
    func animationStop() {
        let topAlphaAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        topAlphaAnimation.duration = 0.5
        topAlphaAnimation.toValue = 0
        topAlphaAnimation.isRemovedOnCompletion = false
        topAlphaAnimation.fillMode = kCAFillModeForwards
        topAlphaAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.topArrowLineLayer.add(topAlphaAnimation, forKey: "topAlphaAnimation")
        
        let bottomAlphaAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        bottomAlphaAnimation.duration = 0.5
        bottomAlphaAnimation.toValue = 0
        bottomAlphaAnimation.isRemovedOnCompletion = false
        bottomAlphaAnimation.fillMode = kCAFillModeForwards
        bottomAlphaAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.bottomArrowLineLayer.add(topAlphaAnimation, forKey: "topAlphaAnimation")
        
        self.circleMaskLayer.removeAllAnimations()
    }
}
