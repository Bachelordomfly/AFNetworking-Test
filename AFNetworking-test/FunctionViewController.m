//
//  FunctionViewController.m
//  AFNetworking-test
//
//  Created by xujiajia on 15/11/25.
//  Copyright © 2015年 xujiajia. All rights reserved.
//
///
#import "FunctionViewController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "CustomBtn.h"
#import "CustomView.h"
#import "AFNetworking.h"
#import "JSONKit.h"

#define _width_ [UIScreen mainScreen].bounds.size.width
#define _height_ [UIScreen mainScreen].bounds.size.height
typedef NS_ENUM(NSInteger, Type)
{
    GET,
    POST,
    POST_MultiPart_Request,
    DownloadFile,
    UploadFile,
    UploadFile_Progress,
    UploadData,
    Get_NetStatues,
    HTTP_Manager_Reachability,
    AFHTTPRequestOperation_GET,
    Batch_of_Operations
    
};

@interface FunctionViewController ()

@property (nonatomic, strong) CustomBtn *start;
@property (nonatomic, strong) CustomBtn *clean;
@property (nonatomic, strong) CustomView *red;
@property (nonatomic, strong) CustomView *green;
@property (nonatomic, strong) CustomView *blue;
@property (nonatomic, strong) UIImageView *iv;
@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _functionName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //创建start按钮
//    self.start = [[CustomBtn alloc] initWithFrame:CGRectMake(15, 64+25, 45, 45)];

    self.start = [[CustomBtn alloc] init];
    self.start.tag = _type;
    [self.start addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置文字和文字颜色
    [self.start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.start setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.start setTitle:@"Start" forState:UIControlStateNormal];
    [self.start setTitle:@"Pause" forState:UIControlStateSelected];
    
    //设置未选中
    self.start.selected = NO;
    
    //设置layer属性
//    self.start.layer.cornerRadius = 30;
//    self.start.layer.masksToBounds = YES;
//    self.start.layer.borderWidth = 2.f;
//    self.start.layer.borderColor = [UIColor redColor].CGColor;
    
    
    [self.view addSubview:self.start];
    UIEdgeInsets pad = UIEdgeInsetsMake(64+25, 10, 500, 300);
    [self.start makeConstraints:^(MASConstraintMaker *make) {
        //
        make.edges.equalTo(self.view).with.insets(pad);
    }];
    
    
    //创建clean按钮
//    self.clean = [[CustomBtn alloc] init];
//    self.clean.tag = 100;
//    self.clean.backgroundColor = [UIColor grayColor];
//    [self.clean setTitle:@"" forState:UIControlStateNormal];
//    
//    [self.view addSubview:self.clean];
//    [self.clean makeConstraints:^(MASConstraintMaker *make) {
//        //
//        make.size.equalTo(self.start);
//        make.top.equalTo(self.start.top);
//        make.bottom.equalTo(self.start.bottom);
//        
//    }];
    
    
    //添加按钮
//    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btn.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:_btn];
//    
//    UIEdgeInsets padding = UIEdgeInsetsMake(64+10, 50, 560, 50);
//   
//    [_btn makeConstraints:^(MASConstraintMaker *make) {
//        
        //设置按钮距离父控件的四周边距
        //方式1
//        make.top.equalTo(self.view.top).with.offset(64+5);
//        make.left.equalTo(self.view.left).with.offset(20);
//        make.bottom.equalTo(self.view.bottom).with.offset(-590);
//        make.right.equalTo(self.view.right).with.offset(-20);
        
        //方式2
//        make.edges.equalTo(self.view).with.insets(padding);
    
        
//        make.edges.equalTo(_iv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        
//        make.width.equalTo(@100);
//        make.height.equalTo(@150);
        
//        make.size.equalTo(self.navigationController.navigationBar);
//        make.center.equalTo(self.view).centerOffset(CGPointMake(0, +10));
//        make.topMargin.equalTo(@10);
//
//    }];
    
    
    //添加 UIImageView
    _iv = [[UIImageView alloc] init];
//    _iv.bounds = CGRectMake(0, 0, _width_, _height_*0.5);
//    _iv.center = CGPointMake(_width_*0.5, _height_*0.5);
    _iv.backgroundColor = [UIColor lightGrayColor];
    
    //
    [self.view addSubview:_iv];
    
    //
//    UIEdgeInsets padding = UIEdgeInsetsMake(64+150, 0, 100, 0);
    [_iv mas_makeConstraints:^(MASConstraintMaker *make) {
        //
//        make.edges.equalTo(self.view).with.insets(padding);
//        make.left.equalTo(self.view.left);
        make.left.lessThanOrEqualTo(@30);
        make.right.greaterThanOrEqualTo(@-30);
//        make.right.lessThanOrEqualTo(@30);
        make.top.equalTo(267);
        make.bottom.equalTo(-200);
    }];
    
    
    /**
     创建红、绿、蓝三个UIView
     */
    self.red = [[CustomView alloc] init];
    self.red.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.red];
    
    self.green = [[CustomView alloc] init];
    self.green.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.green];
    
    self.blue = [[CustomView alloc] init];
    self.blue.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blue];
    
    
    [self.red makeConstraints:^(MASConstraintMaker *make) {
        //一级约束
        make.left.equalTo(self.view.left).offset(20);
        make.bottom.equalTo(self.view.bottom).offset(-40);
        make.height.equalTo(100);
        
        //二级约束(green消失 blue在)
        make.right.equalTo(self.blue.left).offset(-10).priority(500);
        
        //三级约束(blue消失 green在)
        make.right.equalTo(self.green.left).offset(-10).priority(100);
        
        //四级约束
        make.right.equalTo(self.view.right).offset(-20).priority(1);

    }];
    
    [self.green makeConstraints:^(MASConstraintMaker *make) {
        //一级约束
        make.left.equalTo(self.red.right).offset(10);
        make.bottom.width.height.equalTo(self.red);
        //二级约束(blue消失 red在)
        make.right.equalTo(self.view.right).offset(-20).priority(500);
        
        //三级约束(red消失 blue在)
        make.left.equalTo(self.view.left).offset(20).priority(100);
        make.bottom.equalTo(self.view.bottom).offset(-40).priority(100);
        make.height.equalTo(100).priority(100);
        
        //四级约束
        
        
    }];
    
    [self.blue makeConstraints:^(MASConstraintMaker *make) {
        //一级约束
        make.left.equalTo(self.green.right).offset(10);
        make.right.equalTo(self.view.right).offset(-20);
        make.bottom.width.height.equalTo(self.red);
        
        //二级约束(green消失 red在)
        make.left.equalTo(self.red.right).offset(10).priority(500);
        
        //三级约束(red消失 green在) 覆盖一级
        make.bottom.width.height.equalTo(self.green);
     
        //四级约束
        make.left.equalTo(self.view.left).offset(-10).priority(1);
        make.bottom.equalTo(self.view.bottom).offset(-40).priority(1);
        make.height.equalTo(100).priority(1);
        
    }];
    
}


//按钮点击事件
- (void)buttonDidClick:(CustomBtn *)sender
{
    NSLog(@"%s tag:%ld",__func__, sender.tag);
    switch (sender.tag) {
        case GET:
        {
            //访问服务器的一个json文件
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:@"http://127.0.0.1/test.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                //responseObject 和 data 完全一样都是json格式
                NSLog(@"responseObject===%@", responseObject);
                NSData *data = [NSData dataWithData:responseObject];
                NSLog(@"data===%@", data);
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                //
                NSLog(@"error");
            }];
        }
            break;
        case POST:
        {
            //尝试利用第三方API获取数据
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            //设置请求格式, 默认二进制
            /**
            AFHTTPRequestSerializer(二进制)
            AFJSONRequestSerializer(JSON)
            AFPropertyListRequestSerializer(Plist)
             */
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            
            //设置返回格式, 默认json
            /**
             AFHTTPResponseSerializer(二进制)
             *AFJSONResponseSerializer(JSON)
             *AFPropertyListResponseSerializer(Plist)
             *AFXMLParserResponseSerializer(XML)
             *AFImageResponseSerializer(Image)
             *AFCompoundResponseSerializer(组合的)
             */
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
//            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
            //101010100 == 北京
            NSString *dis = [NSString stringWithString:[@"北京" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSDictionary *parametres = @{@"district":dis,@"format":@"json",@"authkey": @"80432e846ade4d8e9ee65ab1ad6c7bfb"};
            
            
            [manager POST:@"http://api.36wu.com" parameters:parametres success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//                id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//                NSLog(@"data===%@", data);
                NSLog(@"responseObject===%@", responseObject);
                //有问题。。。
//                id data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:
//                                nil];
//                NSLog(@"===============================json====%@", data);
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                //
                NSLog(@"error===%@", error);
            }];
            
        }
            break;
        case POST_MultiPart_Request:
        {
            //我并没有写parameters
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSURL *filePath = [NSURL URLWithString:@"http://127.0.0.1/qiutian.jpg"];
            
            //很奇怪，在这里设置和改源码设置，时灵时不灵
//            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"image/jpeg"];
            //如果我post一个json文件 可以成功！但是我post一个jpg 却获取不到responseObject(显示null)
            [manager POST:@"http://127.0.0.1/luori.jpg" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //
                [formData appendPartWithFileURL:filePath name:@"qiutian" error:nil];
                
            } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                //
                NSLog(@"responseObject===%@", responseObject);
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                //
                NSLog(@"error===%@", error);
            }];
        }
            break;
        case DownloadFile:
        {
            //下载了一张图片
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
            
            //使用utf8编码
//            NSURL *url = [NSURL URLWithString:[@"http://127.0.0.1/qiutian.jpg" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/qiutian.jpg"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                //默认下载文件保存的目标路径
                NSLog(@"targetPath===%@ response===%@", targetPath, response.suggestedFilename);
                
                //更改默认目标路径
                NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                
                //网络URL和本地URL是有区别的
                NSURL *netURL = [NSURL URLWithString:path];
                NSURL *loaclURL = [NSURL fileURLWithPath:path];
                
                NSLog(@"netURL===%@", netURL);
                return netURL;
                
                //保存在NSCacheDirectory里
//                NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//                return [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                //
                NSLog(@"filePath===%@ error===%@", filePath, error);
            }];
            
            [task resume];
        }
            break;
        case UploadFile:
        {
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
            
            NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            NSURL *filePath = [NSURL fileURLWithPath:@"http://127.0.0.1/qiutian.jpg"];
            
            NSURLSessionUploadTask *task = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                //
                if(error)
                {
                    NSLog(@"error===%@", error);
                }
                else
                {
                    NSLog(@"response===%@ responseObject===%@", response, responseObject);
                }
            }];
            [task resume];
        }
            break;
        case UploadFile_Progress:
        {
            NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://127.0.0.1/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //
                [formData appendPartWithFileURL:[NSURL URLWithString:@"http://127.0.0.1/luori.jpg"] name:@"" fileName:@"luori.jpg" mimeType:@"luori/jpeg" error:nil];
            } error:nil];
            
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSProgress *progress = nil;
            
            NSURLSessionUploadTask *task = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                //
                if(error)
                {
                    NSLog(@"error===%@", error);
                }
                else
                {
                    NSLog(@"response===%@ responseObject===%@", response, responseObject);
                }
            }];
            [task resume];
            
        }
            break;
        case UploadData:
        {
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            
            NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/upload"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                //
                if(error)
                {
                    NSLog(@"error===%@", error);
                }
                else
                {
                    NSLog(@"response===%@ responseObject===%@", response, responseObject);
                }
            }];
            [task resume];
            
        }
            break;
        case Get_NetStatues:
        {
            /**
             AFNetworkReachabilityStatusUnknown          = -1,
             AFNetworkReachabilityStatusNotReachable     = 0,
             AFNetworkReachabilityStatusReachableViaWWAN = 1,
             AFNetworkReachabilityStatusReachableViaWiFi = 2,
             */
            // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring,这是个监控器
            [[AFNetworkReachabilityManager sharedManager] startMonitoring];
            // 检测网络连接的单例,网络变化时的回调方法
            [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                //
                NSLog(@"NetStatus===%@", AFStringFromNetworkReachabilityStatus(status));
            }];
            
        }
            break;
        case HTTP_Manager_Reachability:
        {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            NSOperationQueue *operationQueue = manager.operationQueue;
            [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                //
                switch (status) {
                    case AFNetworkReachabilityStatusNotReachable:
                    {
                        [operationQueue setSuspended:YES];
                    }
                        break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:
                    {
                        [operationQueue setSuspended:NO];
                    }
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                    {
                        [operationQueue setSuspended:NO];
                    }
                    case AFNetworkReachabilityStatusUnknown:
                    {
                        [operationQueue setSuspended:YES];
                    }
                    default:
                        break;
                }
            }];
            [manager.reachabilityManager startMonitoring];
        }
            break;
        case AFHTTPRequestOperation_GET:
        {
            NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/test.json"];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFHTTPResponseSerializer serializer];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                //
//                NSLog(@"responseObject===%@", responseObject);
                id data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"data===%@", data);
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                //
                NSLog(@"error===%@", error);
            }];
            
            //将该操作添加到主队列才能执行
            [[NSOperationQueue mainQueue] addOperation:operation];
        }
            break;
        case Batch_of_Operations:
        {
            //批量上传, 测试两张图片
            NSArray *filesURL = [NSArray arrayWithObjects:[NSURL URLWithString:@"http://127.0.0.1/qiutian.jpg"], [NSURL URLWithString:@"http://127.0.0.1/luori.jpg"], nil];
            NSMutableArray *mutableOperations = [NSMutableArray array];
            for(NSURL *fileURL in filesURL)
            {
                NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://127.0.0.1/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    //
                    [formData appendPartWithFileURL:fileURL name:@"images[]" error:nil];
                } error:nil];
                
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                [mutableOperations addObject:operation];
            }
            
            NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                //
                NSLog(@"numberOfFinishedOperations===%lu totalNumberOfOperations===%lu", numberOfFinishedOperations, totalNumberOfOperations);
            } completionBlock:^(NSArray * _Nonnull operations) {
                //
                NSLog(@"all file upload success!");
            }];
            
            [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
        }
            break;
        default:
            break;
    }
   
}


- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
