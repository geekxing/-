//
//  FriendTableViewCell.swift
//  小微信
//
//  Created by 赖霄冰 on 16/5/1.
//  Copyright © 2016年 赖霄冰. All rights reserved.
//

import UIKit

let CommentButtonDidTapNotification = "CommentButtonDidTapNotification"

class FriendTableViewCell: UITableViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var commentButton: UIButton!
    var firstEnter = 1
    var friendData = [String]()
    var praiseView: PraiseView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentButton.addTarget(self, action: #selector(comment), forControlEvents: .TouchUpInside)
        firstEnter = 0
        headImgView.userInteractionEnabled = true
        imgView.userInteractionEnabled = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        contentLabel.text = nil
        dateLabel.text = nil
        headImgView.image = nil
        imgView.image = nil
    }
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configureCell(result: JSONResult) {
        titleLabel.text = result.title
        contentLabel.text = result.content
        dateLabel.text = result.time
        if let image = UIImage(named: result.imageName) {
            headImgView.image = UIImage(named: result.imageName)
            imgView.image = image
        }
    }
    
    // MARK: - Cell里面的消息事件
    func comment() {
        print("点击事件")
        NSNotificationCenter.defaultCenter().postNotificationName(CommentButtonDidTapNotification,
                                                                  object: self)
        if firstEnter == 0 {
            praiseView = PraiseView()
            self.contentView.addSubview(praiseView)
        }
        praiseView.array.addObject(friendData[1])
        praiseView.addFriends()
        firstEnter = 1
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
