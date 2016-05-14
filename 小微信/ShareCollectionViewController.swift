//
//  ShareCollectionViewController.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/14.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ShareCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var shareResults = [ShareResult]()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBarHidden = true
        let navigationView = UIView(frame: CGRectMake(0,0,view.bounds.width,30))
        view.addSubview(navigationView)
        collectionView!.backgroundColor = UIColor.whiteColor()
        let shareResult = ShareResult.fillResults()
        for _ in 0...20 {
            shareResults.append(shareResult)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        collectionView!.collectionViewLayout = flowLayout

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print("\(shareResults.count)")
        return shareResults.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ShareCollectionViewCell
        // Configure the cell
        cell.configureCell(shareResults[indexPath.item])
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let length = view.bounds.width * 0.4
        return CGSizeMake(length, length)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(40, 20, 50, 20)
    }

}
