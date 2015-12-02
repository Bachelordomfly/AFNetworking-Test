//
//  RootViewController.m
//  AFNetworking-test
//
//  Created by xujiajia on 15/11/25.
//  Copyright © 2015年 xujiajia. All rights reserved.
//

#import "RootViewController.h"
#import "FunctionViewController.h"
#import "Masonry.h"

#define _width_ [UIScreen mainScreen].bounds.size.width
#define _height_ [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, AnimationType) {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
};


@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) UITableView *table;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
//    self.navigationBarHidden = NO;
//    self.navigationItem.title = @"啦啦啦啦啦";
    
    _data = [NSArray arrayWithObjects:@"GET请求", @"POST请求", @"POST Multi-Part Request", @"创建一个下载文件任务", @"创建一个上传文件任务", @"创建一个上传文件任务并显示进度", @"创建一个上传数据data任务", @"获取网络状态", @" HTTP Manager Reachability", @"AFHTTPRequestOperation的GET请求", @"Batch of Operations",  nil];
    
    _table = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    
    NSLog(@"%lf", self.view.frame.origin.y);
    [self.view addSubview:_table];
    
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    btn.backgroundColor = [UIColor clearColor];
//    [btn setTitle:@"哈哈哈" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    
//    // 1、一定要先添加到父控件
//    [self.view addSubview:btn];
//    // 2、再添加约束
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        //
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, _height_-64, 0));
//    }];
    
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunctionViewController *vc = [[FunctionViewController alloc] init];
    vc.functionName = _data[indexPath.row];
    vc.type = indexPath.row;
//    vc.view.frame = CGRectMake(0, _height_, _width_, _height_);
    
    // 1、使用系统自带动画实现转场
    
    // ModalPresentationStyle 弹出模式
//    UIModalPresentationFullScreen = 0,
//    UIModalPresentationPageSheet
//    UIModalPresentationFormSheet
//    UIModalPresentationCurrentContext
//    UIModalPresentationCustom
//    UIModalPresentationOverFullScreen
//    UIModalPresentationOverCurrentContext
//    UIModalPresentationPopover
//    UIModalPresentationNone
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    
    // ModalTransitionStyle 动画风格
//    UIModalTransitionStyleCoverVertical=0, //默认方式，竖向上推
//    
//    UIModalTransitionStyleFlipHorizontal, //水平反转
//    
//    UIModalTransitionStyleCrossDissolve,//隐出隐现
//    
//    UIModalTransitionStylePartialCurl,//部分翻页效果
    [vc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    
    // 2、自定义动画实现转场
    [self transitionWithType:kCATransitionPush subType:kCATransitionFromTop duration:1.5 forView:self.view];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    
    
    /**
     type 过渡效果
     
     公有type种类
     CA_EXTERN NSString * const kCATransitionFade
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     CA_EXTERN NSString * const kCATransitionMoveIn
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     CA_EXTERN NSString * const kCATransitionPush
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     CA_EXTERN NSString * const kCATransitionReveal
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     
     私有type种类
     @"cube"
     @"suckEffect"
     @"oglFlip"
     @"rippleEffect"
     @"pageCurl"
     @"pageUnCurl"
     @"cameraIrisHollowOpen"
     @"cameraIrisHollowClose"
     */
    
    
    /**
     subtype 过渡开始方向
     CA_EXTERN NSString * const kCATransitionFromRight
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     CA_EXTERN NSString * const kCATransitionFromLeft
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     CA_EXTERN NSString * const kCATransitionFromTop
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     CA_EXTERN NSString * const kCATransitionFromBottom
     __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
     */
    
    

}
//一个CATransition实现转场动画的方法
- (void)transitionWithType:(NSString *)type subType:(NSString *)subtype duration:(CFTimeInterval)duration forView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    
    //动画持续时间
    animation.duration = duration;
    
    //动画过渡效果
    animation.type = type;
    
    //动画过渡方向
    animation.subtype = subtype;
    
    //动画节奏
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:nil];
}










@end
