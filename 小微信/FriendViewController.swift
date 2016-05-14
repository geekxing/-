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
    var messageBtn: UIButton?
    var maskBtn: UIButton?
    var swipeGestureUp: UISwipeGestureRecognizer!
    var swipeGestureDown: UISwipeGestureRecognizer!
    
    var friendData = [String]()

    lazy var headImageView: UIImageView = {
       let imageView = UIImageView(frame: CGRectMake(0, -self.view.bounds.height * 0.3, self.view.bounds.width, self.view.bounds.height * 0.2))
        imageView.image = UIImage(named: "navigation")
        imageView.userInteractionEnabled = true
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
    
    //MARK: - Life Cycle methods
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //点赞功能模拟数据
        friendData = ["李四","Neusoft","我是你的小🍎","1+1=?","德玛西亚万岁","一","你是我的眼","BraverSmile"]
        listenForCommentButtonDidTapNotification()
        
        let statusBackgroundView = UIView(frame: CGRectMake(0,-20,view.bounds.width,20))
        statusBackgroundView.backgroundColor = UIColor.darkGrayColor()
        //navigationController?.navigationBar.addSubview(statusBackgroundView)
        navigationController?.setNavigationBarHidden(true, animated: true)
        for (_, subview) in view.subviews.enumerate() {
            subview.userInteractionEnabled = true
            print("\(subview)")
        }
        
        /* 添加自定义轻扫手势弹出导航菜单 */
        swipeGestureUp = UISwipeGestureRecognizer(target: self, action: #selector(hideMenuBar))
        swipeGestureUp.direction = .Up
        swipeGestureUp.delegate = self
        swipeGestureDown = UISwipeGestureRecognizer(target: self, action: #selector(showMenuBar))
        swipeGestureDown.direction = .Down
        swipeGestureDown.delegate = self

        tableView.addGestureRecognizer(swipeGestureDown)
        tableView.addGestureRecognizer(swipeGestureUp)
        
        /* iOS 7 动态调整Cell高度 */
        tableView.estimatedRowHeight = 200
        //tableView.fd_debugLogEnabled = true
        /* 注册复用Cell */
        var nib = UINib(nibName: "FriendCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "FriendCell")
        
        /* 读取JSON数据 */
        let dataPath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        if let data = NSData(contentsOfFile: dataPath!) {
           jsonResults = parseJSON.loadJSONData(data)
        }
        
        /* 建立表视图的headerView和footerView */
        let headerView = UIView(frame: CGRectMake(0,-40,view.bounds.width,280))
        let headerImgView = UIImageView(frame: CGRectMake(0, -40, view.bounds.width, 240))
        headerImgView.image = UIImage(named: "image1")
        
        let width = view.bounds.width
        headButton = configureButtonWithImageName("head1", andFrame: CGRectMake(width - 110, 135, 100, 100))
        headButton.addTarget(self, action: #selector(clickHeader), forControlEvents: .TouchUpInside)
        nameLabel = configureLabelWithText("赖霄冰",andFrame: CGRectMake(width - 160, 170, 40, 30))
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerImgView)
        headerView.addSubview(headButton)
        headerView.addSubview(nameLabel)
        
        /* 添加头像和名字标签的约束 */
        let constraint1 = NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: .Equal, toItem: headButton, attribute: .Leading, multiplier: 1.0, constant: -10)
        let constraint2 = NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: headerView, attribute: .Top, multiplier: 1.0, constant: 170)
        let constraint3 = NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: .GreaterThanOrEqual, toItem: headerView, attribute: .Leading, multiplier: 1.0, constant: 20)
        constraint1.active = true
        constraint2.active = true
        constraint3.active = true
        
        tableView.tableHeaderView = headerView
        let footerView = UIView()
        footerView.backgroundColor = UIColor.whiteColor()
        tableView.tableFooterView = footerView
        /* 建立上拉刷新 */
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        tableView.mj_header.mj_size = CGSizeMake(50, 20)
        tableView.mj_header.mj_origin = CGPointMake(view.center.x-25, -60)
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
        print("开始滑动")
        tableView.superview!.addSubview(headImageView)
        if messageBtn == nil {
            self.messageBtn = configureButtonWithImageName(nil, andFrame: CGRectMake(15, 35, 30, 40))
            self.messageBtn!.addTarget(self, action: #selector(clickMsg), forControlEvents: .TouchUpInside)
            headImageView.addSubview(self.messageBtn!)
        }
        if maskBtn == nil {
            maskBtn = configureButtonWithImageName(nil, andFrame: CGRectMake(view.bounds.width-45, 35, 30, 40))
            maskBtn!.addTarget(self, action: #selector(clickMask), forControlEvents: .TouchUpInside)
            headImageView.addSubview(maskBtn!)
        }
        tableView.superview!.addSubview(bottomImageView)
        UIView.animateWithDuration(0.6, delay: 0, options: .CurveEaseOut, animations: {
            self.headImageView.frame = CGRectMake(0, 0, self.headImageView.bounds.width, self.headImageView.bounds.height)
            self.bottomImageView.frame = CGRectMake(0, self.view.bounds.height-43-self.bottomImageView.bounds.height, self.bottomImageView.bounds.width, self.bottomImageView.bounds.height)
            }, completion: nil)
    }
    
    func hideMenuBar(gesRecognizer: UISwipeGestureRecognizer) {
        print("开始滑动")
        UIView.animateWithDuration(0.6, delay: 0, options: .CurveEaseIn, animations: {
            self.headImageView.frame = CGRectMake(0, -self.headImageView.bounds.height, self.headImageView.bounds.width, self.headImageView.bounds.height)
            self.bottomImageView.frame = CGRectMake(0, self.view.bounds.height, self.bottomImageView.bounds.width, self.bottomImageView.bounds.height)
        }) { _ in self.headImageView.removeFromSuperview()
            if let msgBtn = self.messageBtn, let mskBtn = self.maskBtn {
                msgBtn.removeFromSuperview()
                self.messageBtn = nil
                mskBtn.removeFromSuperview()
                self.maskBtn = nil
            }
            self.bottomImageView.removeFromSuperview()
        }
    }
    
    /* 响应点击头像事件 */
    func clickHeader() {
        print("点击头像")
        performSegueWithIdentifier("showMyCircle", sender: nil)
    }
    
    func clickMsg() {
        print("点击消息")
        performSegueWithIdentifier("showMessage", sender: nil)
    }
    
    func clickMask() {
        print("发布动态")
        performSegueWithIdentifier("writeLog", sender: nil)
    }
    
    func clickImage(tapGesRecognizer: UITapGestureRecognizer) {
        print("点击图片")
        let point = tapGesRecognizer.locationInView(self.tableView)
        let indexPath = tableView.indexPathForRowAtPoint(point)
        print("\(indexPath?.row)")
        let cell = tableView.cellForRowAtIndexPath(indexPath!)
        performSegueWithIdentifier("ShowImage", sender: cell)
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
    
    func listenForCommentButtonDidTapNotification() {
        NSNotificationCenter.defaultCenter().addObserverForName(CommentButtonDidTapNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            let cell = notification.object as! FriendTableViewCell
            cell.friendData = self.friendData
        }
    }
    
    //MARK: - Data Source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonResults.count
    }

    
//    //MARK: - Delegate
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tapGesRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImage))
        tapGesRecognizer.cancelsTouchesInView = false
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendTableViewCell
        let jsonResult = jsonResults[indexPath.row]
        cell.configureCell(jsonResult)
        cell.selectionStyle = .None
        cell.imgView.addGestureRecognizer(tapGesRecognizer)
        
        return  cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMyCircle" {
            let myCircleVC = segue.destinationViewController as! MyCircleTableViewController
            myCircleVC.headImageName = "head1"
            myCircleVC.nameLabelText = nameLabel.text
        }
        if segue.identifier == "ShowImage" {
            let cell = sender as! FriendTableViewCell
            let showImgVC = segue.destinationViewController as! ShowImageViewController
            if let image = cell.imgView.image {
                showImgVC.image = image
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("FriendCell", configuration: { (cell) in
            let cell = cell as! FriendTableViewCell
            
            let jsonResult = self.jsonResults[indexPath.row]
            cell.configureCell(jsonResult)
        })
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
