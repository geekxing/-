//
//  MyCircleTableViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/2.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class MyCircleTableViewController: UITableViewController {
    
    var headButton: UIButton!
    var nameLabel: UILabel!
    var nameLabelText: String!
    var headImageName: String!
    var results = [Int]()

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "HeadImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "HeadImageCell")
        

        headButton = configureButtonWithImageName(headImageName)
        headButton.addTarget(self, action: #selector(clickHeader), forControlEvents: .TouchUpInside)
        
        nameLabel = configureLabelWithText(nameLabelText)
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
    }
    
    func clickHeader() {
        print("点击头像")
        //performSegueWithIdentifier("showMyCircle", sender: nil)
    }
    
    func loadNewData() {
        //1、获取更多数据
        for index in 0...5 {
            results.append(index)
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

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count == 0 ? 1 : results.count
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("HeadImageCell") as! HeadImageTableViewCell
            cell.bigImageView.image = UIImage(named: "image1")
            let width = UIScreen.mainScreen().bounds.width
            cell.separatorInset = UIEdgeInsetsMake(0, width, 0, 0)
            return cell
        } else {
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "DefaultCell")
            cell.textLabel?.text = "\(results[indexPath.row])"
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        } else {
            return 44
        }
    }
}
