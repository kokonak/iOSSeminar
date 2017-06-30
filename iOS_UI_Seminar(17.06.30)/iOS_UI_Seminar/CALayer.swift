//
//  CALayer.swift
//  pita
//
//  Created by KOKONAK on 2017. 4. 3..
//  Copyright © 2017년 MyMusicTaste. All rights reserved.
//

import UIKit

extension CALayer {
    func pauseAnimation() {
        let pausedTime = self.convertTime(CACurrentMediaTime(), from: nil)
        self.speed = 0
        self.timeOffset = pausedTime
    }
    func resumeAnimation() {
        let pausedTime = self.timeOffset
        self.speed = 1
        self.timeOffset = 0
        self.beginTime = 0
        let timeSincePause = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }

}
