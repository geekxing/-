//
//  MyMsgTableViewCell.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/6.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit


class MyMsgTableViewCell: UITableViewCell {

    enum State {
        case zan
        case reply
    }
    
    private(set) var state: State = .reply
    
    @IBOutlet weak var headImgView: HeaderImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentContentLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var zanImageView: HeaderImageView!
    @IBOutlet weak var replyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switch state {
        case .zan:
            commentLabel.removeFromSuperview()
            replyButton.removeFromSuperview()
            commentContentLabel.removeConstraints(constraints)
            commentContentLabel.translatesAutoresizingMaskIntoConstraints = false
            let constraint1 = NSLayoutConstraint(item: commentContentLabel, attribute: .Leading, relatedBy: .Equal, toItem: contentView, attribute: .Leading, multiplier: 1.0, constant: 10)
            let constraint2 = NSLayoutConstraint(item: commentContentLabel, attribute: .Top, relatedBy: .Equal, toItem: headImgView, attribute: .Bottom, multiplier: 1.0, constant: 8)
            let constraint3 = NSLayoutConstraint(item: commentContentLabel, attribute: .Trailing, relatedBy: .Equal, toItem: zanImageView, attribute: .Leading, multiplier: 1.0, constant: -10)
            let constraint4 = NSLayoutConstraint(item: infoLabel, attribute: .Trailing, relatedBy: .Equal, toItem: zanImageView, attribute: .Leading, multiplier: 1.0, constant: -10)
            let constraint5 = NSLayoutConstraint(item: infoLabel, attribute: .Top, relatedBy: .Equal, toItem: commentContentLabel, attribute: .Bottom, multiplier: 1.0, constant: 8)
            constraint1.active = true
            constraint2.active = true
            constraint3.active = true
            constraint4.active = true
            constraint5.active = true
        case .reply:
            zanImageView.removeFromSuperview()
            commentContentLabel.translatesAutoresizingMaskIntoConstraints = true
            infoLabel.translatesAutoresizingMaskIntoConstraints = true
            let constraint1 = NSLayoutConstraint(item: commentContentLabel, attribute: .Trailing, relatedBy: .Equal, toItem: contentView, attribute: .Trailing, multiplier: 1.0, constant: 10)
            let constraint2 = NSLayoutConstraint(item: infoLabel, attribute: .Trailing, relatedBy: .Equal, toItem: contentView, attribute: .Trailing, multiplier: 1.0, constant: 10)
            constraint1.active = true
            constraint2.active = true
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
    }

}
