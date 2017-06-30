//  Reference : https://github.com/vinit5320/FliudLoadingIndicator/tree/master/Pods/BAFluidView

//  PTFluidLayer.swift
//  pita
//
//  Created by KOKONAK on 2017. 2. 1..
//  Copyright © 2017년 MyMusicTaste. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


private let horizontalAniString: String = "horizontalAnimation"
private let waveCrestAniString: String = "waveCrestAnimation"

class PTFluidLayer: CAShapeLayer {
    fileprivate(set) var maxAmplitude: CGFloat!
    fileprivate(set) var minAmplitude: CGFloat!
    fileprivate(set) var amplitudeIncrement: CGFloat!
    
    fileprivate var waveLength: CGFloat = 0
    fileprivate var amplitudeArray: [CGFloat] = []
    fileprivate var animating: Bool = false
    
    fileprivate var finalX: CGFloat = 0
    fileprivate var startingAmplitude: CGFloat = 0
    
    fileprivate var waveCrestAnimation: CAKeyframeAnimation!
    fileprivate var timer: Timer?
    
    fileprivate let gradient: CAGradientLayer = CAGradientLayer()
    fileprivate let animationLayer: CAShapeLayer = CAShapeLayer()
    
    fileprivate var horizontalAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position.x")
    var horizontalDuration: Double = 0
    var waveCrestDuration: Double = 0
    init(frame: CGRect, minAmplitude: CGFloat, maxAmplitude: CGFloat, amplitudeIncrement: CGFloat) {
        super.init()
        self.maxAmplitude = maxAmplitude
        self.minAmplitude = minAmplitude
        self.amplitudeIncrement = amplitudeIncrement
        
        self.waveLength = frame.width
        self.finalX = self.waveLength * 2
        
        self.frame = frame
        
        self.animationLayer.anchorPoint = CGPoint(x: 0, y: frame.height)
        self.animationLayer.frame = CGRect(x: self.waveLength, y: 0, width: self.finalX, height: frame.height)
        self.animationLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.finalX, height: frame.height)).cgPath
        
        self.amplitudeArray = self.createAmplitudeOptions()
        
        self.gradient.frame = CGRect(x: -self.waveLength, y: 0, width: frame.width*3, height: frame.height + self.maxAmplitude)
        self.gradient.colors = [UIColor(red:0.27, green:0.58, blue:0.96, alpha:1.00).cgColor, UIColor(red:0.73, green:0.40, blue:0.83, alpha:1.00).cgColor]
        self.gradient.startPoint = CGPoint(x: 0, y: 0)
        self.gradient.endPoint = CGPoint(x: 1, y: 1)
        self.gradient.mask = self.animationLayer
        self.gradient.opacity = 0.5
        self.addSublayer(self.gradient)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createAmplitudeOptions() -> [CGFloat] {
        var array: [CGFloat] = []
        
        array.append(0)
        array.append(0)
        
        var i: CGFloat = self.minAmplitude
        while i <= self.maxAmplitude {
            array.append(i)
            i += self.amplitudeIncrement
        }
        return array
    }
    
    func stopAnimation() {
        if self.timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        self.animationLayer.removeAnimation(forKey: horizontalAniString)
        self.animationLayer.removeAnimation(forKey: waveCrestAniString)
        self.waveCrestAnimation = nil
        self.animating = false
        
        self.animationLayer.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.finalX, height: self.frame.height)).cgPath
    }
    
    override func pauseAnimation() {
        self.animationLayer.pauseAnimation()
    }
    override func resumeAnimation() {
        self.horizontalAnimation.values = [self.animationLayer.position.x, (-self.finalX + self.waveLength)]
        self.horizontalAnimation.duration = self.horizontalDuration
        self.horizontalAnimation.repeatCount = FLT_MAX
        self.animationLayer.add(self.horizontalAnimation, forKey: horizontalAniString)
        
        self.animationLayer.resumeAnimation()
    }
    
    
    func addHorizontalAnimation() {
        self.animationLayer.add(self.horizontalAnimation, forKey: horizontalAniString)
    }
    func removeHorizontalAnimation() {
        self.animationLayer.removeAnimation(forKey: horizontalAniString)
    }
    
    func startAnimation() {
        if !self.animating {
            self.startingAmplitude = self.minAmplitude
            
            self.horizontalAnimation.values = [self.animationLayer.position.x, 0]
            self.horizontalAnimation.duration = self.horizontalDuration
            self.horizontalAnimation.repeatCount = FLT_MAX
//            self.animationLayer.addAnimation(self.horizontalAnimation, forKey: horizontalAniString)
            
            self.waveCrestAnimation = CAKeyframeAnimation(keyPath: "path")
            self.waveCrestAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            self.waveCrestAnimation.values = self.getBezierPathValues(0)
            self.waveCrestAnimation.duration = self.waveCrestDuration
            self.waveCrestAnimation.isRemovedOnCompletion = false
            self.waveCrestAnimation.fillMode = kCAFillModeForwards
            self.timer = Timer.scheduledTimer(timeInterval: self.waveCrestDuration, target: self, selector: #selector(updateWaveCrestAnimation), userInfo: nil, repeats: true)
        }
    }
    
    func updateWaveCrestAnimation() {
        self.animationLayer.removeAnimation(forKey: waveCrestAniString)
        var index: Int = Int(arc4random_uniform(UInt32(self.amplitudeArray.count)))
        if index == 0 || index == 1 {
            index = 2
        }
        self.waveCrestAnimation.values = self.getBezierPathValues(index)
        self.animationLayer.add(self.waveCrestAnimation, forKey: waveCrestAniString)
    }
    
    func getBezierPathValues(_ index: Int) -> [CGPath] {
        let startPoint: CGPoint = CGPoint(x: 0, y: self.frame.height)
        
        let index: Int = index
        
        let finalAmplitude = self.amplitudeArray[index]
        
        var values: [CGPath] = []
        
        if self.startingAmplitude >= finalAmplitude {
            var j: CGFloat = self.startingAmplitude
            while j >= finalAmplitude {
                let line = UIBezierPath()
                line.move(to: startPoint)
                
                var tempAmplitude = j
                
                var i: CGFloat = self.waveLength/2
                while i <= self.finalX {
                    line.addQuadCurve(to: CGPoint(x: startPoint.x + i, y: startPoint.y), controlPoint: CGPoint(x: startPoint.x + i - (self.waveLength/4), y: startPoint.y + tempAmplitude))
                    tempAmplitude = -tempAmplitude
                    i += self.waveLength/2
                }
                
                line.addLine(to: CGPoint(x: self.finalX, y: 0))
                line.addLine(to: CGPoint(x: 0, y: 0))
                line.close()
                
                values.append(line.cgPath)
                
                j -= self.amplitudeIncrement
            }
        }
        else {
            var j: CGFloat = self.startingAmplitude
            while j <= finalAmplitude {
                let line = UIBezierPath()
                line.move(to: startPoint)
                
                var tempAmplitude = j
                
                var i: CGFloat = self.waveLength/2
                while i <= self.finalX {
                    line.addQuadCurve(to: CGPoint(x: startPoint.x + i, y: startPoint.y), controlPoint: CGPoint(x: startPoint.x + i - (self.waveLength/4), y: startPoint.y + tempAmplitude))
                    tempAmplitude = -tempAmplitude
                    i += self.waveLength/2
                }
                
                line.addLine(to: CGPoint(x: self.finalX, y: 0))
                line.addLine(to: CGPoint(x: 0, y: 0))
                line.close()
                
                values.append(line.cgPath)
                
                j += self.amplitudeIncrement
            }
        }
        
        self.startingAmplitude = finalAmplitude
        return values
    }
}
