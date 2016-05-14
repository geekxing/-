//
//  ShareCollectionViewCell.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/14.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

class ShareCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderWidth = 0.5
    }
    
    func configureCell(shareResult: ShareResult) {
        imageView.image = UIImage(named: shareResult.imageName)
        descripLabel.text = shareResult.descripText
        priceLabel.text = shareResult.price
    }
}
