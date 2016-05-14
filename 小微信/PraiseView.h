//
//  PraiseView.h
//  CircleOFFriends
//
//  Created by 肖野 on 15/3/9.
//  Copyright (c) 2015年 nueMike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PraiseView : UIView
@property (nonatomic, strong) NSMutableArray *array; //点赞的朋友数组
@property (nonatomic, assign) NSInteger flag;  //标记点赞的行数
@property (nonatomic, getter=isFirst) BOOL first; //标记第一次进入下一行
@property (nonatomic, assign) NSInteger firstEnter; //第一次点赞

/*!
 *  @brief  按钮列表
 *
 *  @since 当前按钮需要借助前一个按钮，确定x值，所以存在一个数组中
 */
@property (nonatomic, strong) NSMutableArray *btnArray;

/*!
 *  @brief  PraiseView的初始化方法
 *
 *  @param  frame
 *
 *  @return self
 *
 *  @since
 */
-(id)initWithFrame:(CGRect)frame;

/*!
 *  @brief  添加点赞朋友
 */
-(void)addFriends;
@end
