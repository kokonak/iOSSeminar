//
//  PTFluidView.swift
//  pita
//
//  Created by KOKONAK on 2017. 2. 1..
//  Copyright © 2017년 MyMusicTaste. All rights reserved.
//

import UIKit

class PTFluidView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var subLayers: [PTFluidLayer] = []
    func initElements() {
        for i in 0..<1 {
            let shapeLayer: PTFluidLayer = PTFluidLayer(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height/2), minAmplitude: 10, maxAmplitude: 50, amplitudeIncrement: 5)
            self.layer.addSublayer(shapeLayer)
            shapeLayer.horizontalDuration = Double(i) * 0.5 + 1.0
            shapeLayer.waveCrestDuration = shapeLayer.horizontalDuration/2
//            shapeLayer.fillColor = UIColor(red:0.25, green:0.52, blue:0.87, alpha:0.50).CGColor
            self.subLayers.append(shapeLayer)
        }
    }
    func startAnimation() {
        for fluidLayer in self.subLayers {
            fluidLayer.startAnimation()
            
        }
    }
    func resumeAnimation() { 
        for fluidLayer in self.subLayers {
            fluidLayer.resumeAnimation()
        }
    }
    func pauseAnimation() {
        for fluidLayer in self.subLayers {
            fluidLayer.pauseAnimation()
        }
    }
    func stopAnimation() {
        for fluidLayer in self.subLayers {
            fluidLayer.stopAnimation()
        }
    }
    
    func addHorizontalAnimation() {
        for fluidLayer in self.subLayers {
            fluidLayer.addHorizontalAnimation()
        }
    }
    func removeHorizontalAnimation() {
        for fluidLayer in self.subLayers {
            fluidLayer.removeHorizontalAnimation()
        }
    }
}
