//
//  HeadImageTableViewCell.swift
//  小微信
//
//  Created by 赖霄冰 on 16/4/27.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class HeadImageTableViewCell: UITableViewCell {

    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headImageView.layer.borderWidth = 0.5
        headImageView.layer.borderColor = UIColor.blueColor().CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func sizeThatFits(size: CGSize) -> CGSize {
//        var totalHeight: CGFloat = 0
//        totalHeight += bigImageView.sizeThatFits(size).height
//        totalHeight += 40
//        return CGSizeMake(size.width, totalHeight)
//    }

}
