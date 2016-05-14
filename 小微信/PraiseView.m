//
//  PraiseView.m
//  CircleOFFriends
//
//  Created by 肖野 on 15/3/9.
//  Copyright (c) 2015年 nueMike. All rights reserved.
//

#import "PraiseView.h"
#define CREATE_BUTTON(X,Y,WIDTH,TITLE) [self addButtonWithX:X y:Y width:WIDTH title:TITLE]
#define UPDATEFRAME [self updateAviewFrame];

@implementation PraiseView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.flag = 0;
        self.first = 0;
        self.firstEnter = 0;
        self.frame = frame;
        self.backgroundColor =[UIColor colorWithWhite:0.9 alpha:0.8];
        
        [self setTag:2];
        UIImageView *aImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [aImage setImage:[UIImage imageNamed:@"4.jpg"]];
        
        [self addSubview:aImage];
    }
    return self;
}


#pragma mark app用户名肯定会限制一个最大长度，这里假设最大长度是300, 下面添加了极端情况的处理
-(void)addFriends
{
    
    /*!
     *  @brief  点赞第一行
     *
     *  @since 第一行有一个小图标，需要特殊处理
     */
    if (self.flag == 0) {
        //判断第一个元素，因为涉及到数组越界问题
        if (_array.count == 1) {
            if ([self getBtnLabelWeith:[_array lastObject]]+ 35 <= 300 ) {
                CREATE_BUTTON(35, 0, [self getBtnLabelWeith:_array[0]], _array[0]);
            }
            else
            {
                self.flag ++;
                UPDATEFRAME;
                self.first = YES;
                
                CREATE_BUTTON(0, self.flag * 30, [self getBtnLabelWeith:_array[0]], _array[0]);
            }
        }else
        {
            //第二个元素开始
            //当前元素字符串长度
            CGFloat width =[self getBtnLabelWeith:[_array lastObject]] + [self getBtnLabelWeith:@", "];
            //前一个元素x加上width， 得到当前的x值
            CGFloat x = ((UIButton *)self.btnArray.lastObject).frame.origin.x + ((UIButton *)self.btnArray.lastObject).frame.size.width + 1;
            
            if ( width + x  <= 300) {
                CREATE_BUTTON(x, 30 * self.flag, width, ([NSString stringWithFormat:@", %@", [self.array lastObject]]));
            }
            else
            {
                self.flag ++;
                UPDATEFRAME;
                self.first = YES;
                CREATE_BUTTON(0, 30 * self.flag, width, ([NSString stringWithFormat:@", %@", [self.array lastObject]]));
            }
        }
    }else
    {
        CGFloat width =[self getBtnLabelWeith:[_array lastObject]] + [self getBtnLabelWeith:@", "];
        //前一个元素x加上width， 得到当前的x值
        if (self.isFirst == YES) {
            CREATE_BUTTON(0, 30 * self.flag, width, ([NSString stringWithFormat:@", %@", [self.array lastObject]]));
        }else
        {
            CGFloat x = ((UIButton *)self.btnArray.lastObject).frame.origin.x + ((UIButton *)self.btnArray.lastObject).frame.size.width + 1;
            if ( width + x  <= 300) {
                CREATE_BUTTON(x, 30 * self.flag, width, ([NSString stringWithFormat:@", %@", [self.array lastObject]]));
            }else
            {
                self.flag ++;
                UPDATEFRAME;
                self.first = YES;
                
                CREATE_BUTTON(0, 30 * self.flag, width, ([NSString stringWithFormat:@", %@", [self.array lastObject]]));
            }
        }
    }
    self.first = NO;
}
#pragma mark 更新aview的frame

-(void)updateAviewFrame
{
    self.frame = CGRectMake(50, 300, self.frame.size.width, 30 * (_flag + 1));
}
#pragma mark 添加按钮
-(void)addButtonWithX:(CGFloat) x
                    y:(CGFloat) y
                width:(CGFloat) width
                title:(NSString *)title
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(x, y, width, 30)];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[self viewWithTag:2] addSubview:btn];
    
    [self.btnArray addObject:btn];
}

- (void)btnClick:(UIButton *)sender {
    NSString *name = [NSString stringWithFormat:@"%@",sender.titleLabel.text];
    NSLog(@"点击按钮%@",name);
}

#pragma mark 判断宽度
-(CGFloat)getBtnLabelWeith:(NSString *)str
{
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30)
                                       options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.width;
}


#pragma mark 初始化数组
-(NSMutableArray *)btnArray
{
    if (!_btnArray) _btnArray = [[NSMutableArray alloc] init];
    return _btnArray;
}

-(NSMutableArray *)array
{
    if (!_array) _array = [[NSMutableArray alloc] init];
    return _array;
}
@end
