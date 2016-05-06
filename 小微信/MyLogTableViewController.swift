//
//  MyLogTableViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/6.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class MyLogTableViewController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(tableView.sectionHeaderHeight)")
        tableView.contentInset = UIEdgeInsetsMake(-32, 0, 0, 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
