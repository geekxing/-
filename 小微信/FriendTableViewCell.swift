//
//  FriendTableViewCell.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/1.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        contentLabel.text = nil
        userLabel.text = nil
        dateLabel.text = nil
        imgView.image = nil
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configureCell(result: JSONResult) {
        titleLabel.text = result.title
        contentLabel.text = result.content
        userLabel.text = result.username
        dateLabel.text = result.time
        if let image = UIImage(named: result.imageName) {
            imgView.image = image
        }
    }
    
    
    
//    override func sizeThatFits(size: CGSize) -> CGSize {
//        var totalHeight: CGFloat = 0
//        totalHeight += titleLabel.sizeThatFits(size).height
//        totalHeight += contentLabel.sizeThatFits(size).height
//        totalHeight += userLabel.sizeThatFits(size).height
//        totalHeight += imgView.sizeThatFits(size).height
//        totalHeight += 40
//        return CGSizeMake(size.width, totalHeight)
//    }

}
