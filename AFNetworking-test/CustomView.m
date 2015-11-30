//
//  CustomView.m
//  AFNetworking-test
//
//  Created by RenSihao on 15/11/26.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置可交互
        self.userInteractionEnabled = YES;
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDidTap:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)handleDidTap:(UITapGestureRecognizer *)tap
{
    //从父控件移除
//    [self removeFromSuperview];
    
    //开启3秒动画效果
    [UIView animateWithDuration:3.f animations:^{
        [self removeFromSuperview];
        [self.superview layoutIfNeeded];
    }];
    
}


@end
