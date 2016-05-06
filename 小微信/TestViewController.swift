//
//  TestViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/4.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    lazy var infoLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(100, 100, 20, 20))
        label.text = "上滑手势"
        label.sizeToFit()
        label.backgroundColor = UIColor.blueColor()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UpswipeGesRecognizer(target: self, action: #selector(showMenuBar))
        //swipeGesture.direction = .Up
        view.backgroundColor = UIColor.greenColor()
        view.addGestureRecognizer(swipeGesture)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenuBar() {
        print("上滑手势")
        view.addSubview(infoLabel)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKindOfClass(UISwipeGestureRecognizer) {
            return false
        } else {
            return true
        }
    }
}
