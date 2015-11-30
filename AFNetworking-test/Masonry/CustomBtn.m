//
//  CustomBtn.m
//  AFNetworking-test
//
//  Created by RenSihao on 15/11/25.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)click
{
    self.selected = !(self.selected);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef cont = UIGraphicsGetCurrentContext();
    
    //设置线条样式
    CGContextSetLineCap(cont, kCGLineCapRound);
    
    //设置线条宽度
    CGContextSetLineWidth(cont, 2.0f);
    
    //设置描绘颜色
    CGContextSetRGBStrokeColor(cont, 1.0, 0.5, 1.0, 1.0);
    //设置填充颜色
    CGContextSetRGBFillColor(cont, 1.0, 0.5, 1.0, 1.0);
    
    //1、矩形
    //开启一条路径
    CGContextBeginPath(cont);
    
//    CGContextMoveToPoint(cont, 0, 0);
//    CGContextAddLineToPoint(cont, rect.size.width, 0);
//    CGContextAddLineToPoint(cont, rect.size.width, rect.size.height);
//    CGContextAddLineToPoint(cont, 0, rect.size.height);
//    
    
    
    if(self.tag == 100)
    {
        //2、圆形
        CGContextAddArc(cont, rect.size.width*0.5, rect.size.height*0.5, rect.size.width*0.5, 1, 360, 1);
        CGContextFillPath(cont);
        return ;
    }
    
    
    if(self.selected == NO)
    {
        //3、三角形
        CGContextMoveToPoint(cont, 0, 0);
        CGContextAddLineToPoint(cont, rect.size.width, rect.size.height*0.5);
        CGContextAddLineToPoint(cont, 0, rect.size.height);
        CGContextAddLineToPoint(cont, 0, 0);
        
    }
    else
    {
        //4、筷子形
        CGContextMoveToPoint(cont, rect.size.width/3, 0);
        CGContextAddLineToPoint(cont, rect.size.width/3, rect.size.height);
        CGContextMoveToPoint(cont, rect.size.width/3*2, 0);
        CGContextAddLineToPoint(cont, rect.size.width/3*2, rect.size.height);
    }
    
    
    
    //连接重绘
    CGContextStrokePath(cont);
    //填充重绘
//    CGContextFillPath(cont);
}
//去除高亮状态
- (void)setHighlighted:(BOOL)highlighted
{}

@end
