//
//  UpswipeGesRecognizer.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/4.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class UpswipeGesRecognizer: UIGestureRecognizer {
    
    var finished = false
    
    override func reset() {
        super.reset()
        finished = false
        state = .Possible
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if touches.count != 1 {
            self.state = .Failed
            return
        }
        state = .Possible
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        if self.state == .Failed {
            return
        }
        
        let nowPoint = touches.first!.locationInView(self.view)
        let prePoint = touches.first!.previousLocationInView(self.view)
        let deltaX = fabs(nowPoint.x - prePoint.x)
        let deltaY = prePoint.y - nowPoint.y
        if deltaY > 0 && deltaX < 10 {
            finished = true
        } else {
            self.state = .Failed
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        if finished {
            self.state = .Ended
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesCancelled(touches, withEvent: event)
        finished = false
        self.state = .Failed
    }
}
