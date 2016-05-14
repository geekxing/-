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
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        
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
//        return results.count == 0 ? 1 : results.count
        return results.count
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "DefaultCell")
        cell.textLabel?.text = "\(results[indexPath.row])"
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

