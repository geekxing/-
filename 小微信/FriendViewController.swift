//
//  FriendViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/27.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class FriendViewController: UITableViewController {
    
    var headButton: UIButton!
    var nameLabel: UILabel!

    lazy var headImageView: UIImageView = {
       let imageView = UIImageView(frame: CGRectMake(0, -self.view.bounds.height * 0.3, self.view.bounds.width, self.view.bounds.height * 0.3))
        imageView.image = UIImage(named: "navigation")
       return imageView
    }()
    lazy var bottomImageView: UIImageView = {
        print("建立")
       let imageView = UIImageView(frame: CGRectMake(0,self.view.bounds.height, self.view.bounds.width, self.view.bounds.height * 0.3))
        imageView.image = UIImage(named: "bottom")
        return imageView
    }()
    var jsonResults = [JSONResult]()
    let parseJSON = ParseJSON()
    deinit {
        print("退出朋友圈")
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBackgroundView = UIView(frame: CGRectMake(0,-20,view.bounds.width,20))
        statusBackgroundView.backgroundColor = UIColor.darkGrayColor()
        view.addSubview(statusBackgroundView)
        for (_, subview) in view.subviews.enumerate() {
            subview.userInteractionEnabled = true
            print("\(subview)")
        }
        tableView.scrollEnabled = false
        let swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(showMenuBar))
        swipeGestureUp.direction = .Up
        let swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(showMenuBar))
        swipeGestureDown.direction = .Down
        view.addGestureRecognizer(swipeGestureDown)
        view.addGestureRecognizer(swipeGestureUp)
        navigationController?.navigationBarHidden = true
        tableView.estimatedRowHeight = 200
        //tableView.fd_debugLogEnabled = true
        var nib = UINib(nibName: "HeadImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "HeadImageCell")
        nib = UINib(nibName: "FriendCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "FriendCell")
        let dataPath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        if let data = NSData(contentsOfFile: dataPath!) {
           jsonResults = parseJSON.loadJSONData(data)
        }
        
        headButton = configureButtonWithImageName("head1")
        headButton.addTarget(self, action: #selector(clickHeader), forControlEvents: .TouchUpInside)
        
        nameLabel = configureLabelWithText("赖霄冰")
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.insertSubview(headButton, atIndex: 1)
        tableView.insertSubview(nameLabel, atIndex: 2)
        
        let _superView = headButton.superview!
        
        /* 建立头像和名字之间的约束 */
        let constraint1  = NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: .Equal, toItem: headButton , attribute: .Leading, multiplier: 1, constant: -10)
        let constraint2 = NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: _superView, attribute: .Top, multiplier: 1.0, constant: 190)
        let constraint3 = NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: .GreaterThanOrEqual, toItem: _superView, attribute: .Leading, multiplier: 1.0, constant: 20)
        constraint1.active = true
        constraint2.active = true
        constraint3.active = true
        
        navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        /* 建立上拉刷新 */
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        self.tableView.mj_header.automaticallyChangeAlpha = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - 自定义方法
    
    /* 响应轻扫手势弹出导航菜单 */
    func showMenuBar(gesRecognizer: UISwipeGestureRecognizer) {
        if gesRecognizer.direction == .Up {
            print("开始滑动")
            view.addSubview(headImageView)
            view.addSubview(bottomImageView)
            UIView.animateWithDuration(0.6, delay: 0, options: .CurveEaseOut, animations: {
                self.headImageView.frame = CGRectMake(0, 0, self.headImageView.bounds.width, self.headImageView.bounds.height)
                self.bottomImageView.frame = CGRectMake(0, self.view.bounds.height-60-self.bottomImageView.bounds.height, self.bottomImageView.bounds.width, self.bottomImageView.bounds.height)
                }, completion: nil) }
        if gesRecognizer.direction == .Down {
            UIView.animateWithDuration(0.6, delay: 0, options: .CurveEaseIn, animations: {
                self.headImageView.frame = CGRectMake(0, -self.headImageView.bounds.height, self.headImageView.bounds.width, self.headImageView.bounds.height)
                self.bottomImageView.frame = CGRectMake(0, self.view.bounds.height, self.bottomImageView.bounds.width, self.bottomImageView.bounds.height)
            }) { _ in self.headImageView.removeFromSuperview()
                      self.bottomImageView.removeFromSuperview()
            }
        }
    }
    
    /* 响应点击头像事件 */
    func clickHeader() {
        print("点击头像")
        performSegueWithIdentifier("showMyCircle", sender: nil)
    }
    
    /* 上拉刷新数据 */
    func loadNewData() {
        //1、获取更多数据
        for result in jsonResults {
            jsonResults.append(result)
        }
        //2、刷新
        tableView.reloadData()
        //3、关闭mj_header
        tableView.mj_header.endRefreshing()
    }
    
    //MARK: - Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonResults.count
    }

    
//    //MARK: - Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HeadImageCell", forIndexPath: indexPath) as! HeadImageTableViewCell
            cell.bigImageView.image = UIImage(named: "image1")
            let width = UIScreen.mainScreen().bounds.width
            cell.separatorInset = UIEdgeInsetsMake(0, width, 0, 0)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell
            let jsonResult = jsonResults[indexPath.row]
            cell.configureCell(jsonResult)
            cell.selectionStyle = .None
            return  cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMyCircle" {
            let myCircleVC = segue.destinationViewController as! MyCircleTableViewController
            myCircleVC.headImageName = "head1"
            myCircleVC.nameLabelText = nameLabel.text
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        } else {
            return tableView.fd_heightForCellWithIdentifier("FriendCell", configuration: { (cell) in
                let cell = cell as! FriendTableViewCell
                
                let jsonResult = self.jsonResults[indexPath.row]
                cell.configureCell(jsonResult)
            })
        }
    }
}

extension FriendViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension FriendViewController: UINavigationBarDelegate {
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}
