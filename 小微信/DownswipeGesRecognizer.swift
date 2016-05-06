//
//  DownswipeGesRecognizer.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/4.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class DownswipeGesRecognizer: UIGestureRecognizer {
    
    var finished = false
    
    override func reset() {
        super.reset()
        state = .Possible
        finished = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if touches.count != 1 {
            state = .Failed
            return
        }
        state = .Possible
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        if state == .Failed {
            return
        }

        let nowPoint = touches.first!.locationInView(self.view)
        let prePoint = touches.first!.previousLocationInView(self.view)
        let deltaX = fabs(nowPoint.x - prePoint.x)
        let deltaY = nowPoint.y - prePoint.y
        if deltaY > 0 && deltaX < 10 {
            finished = true
        } else {
            state = .Failed
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        if (state == .Possible) && finished == true {
            state = .Ended
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesCancelled(touches, withEvent: event)
        finished = false
        state = .Failed
    }

}
