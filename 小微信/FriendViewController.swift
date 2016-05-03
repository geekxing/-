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

    var jsonResults = [JSONResult]()
    let parseJSON = ParseJSON()
    deinit {
        print("退出朋友圈")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.fd_debugLogEnabled = true
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
        
        let constraint1  = NSLayoutConstraint(item: nameLabel, attribute: .Trailing, relatedBy: .Equal, toItem: headButton , attribute: .Leading, multiplier: 1, constant: -10)
        let constraint2 = NSLayoutConstraint(item: nameLabel, attribute: .Top, relatedBy: .Equal, toItem: _superView, attribute: .Top, multiplier: 1.0, constant: 190)
        let constraint3 = NSLayoutConstraint(item: nameLabel, attribute: .Leading, relatedBy: .GreaterThanOrEqual, toItem: _superView, attribute: .Leading, multiplier: 1.0, constant: 20)
        constraint1.active = true
        constraint2.active = true
        constraint3.active = true
        
        navigationController?.navigationBar.backgroundColor = UIColor.clearColor()

        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        
        self.tableView.mj_header.automaticallyChangeAlpha = true
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func clickHeader() {
        print("点击头像")
        performSegueWithIdentifier("showMyCircle", sender: nil)
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
