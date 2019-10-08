//
//  ViewController.m
//  afn_demo
//
//  Created by Dean on 2018/4/17.
//  Copyright © 2018年 tz. All rights reserved.
//

/*
 urlStr = @"http://api.douban.com/v2/movie/top250";
 
     NSDictionary *dic = @{@"start":@(1),
     @"count":@(5)
     };
 */

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"
/*
 1.发起请求：urlsessionmanager 减少了主类的复杂度，提高维护
 2.请求过程 delegate
 3.请求完成 delegate
 
 系统原生的进度是通过代理
 af提供了block
 */
@interface ViewController ()
@property(strong ,nonatomic)UIImageView *iv ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 链式编程
//    [[[[self get] get] get] get];
    
//    [self get];
    
    self.get.method ;
    
    // 加载图片
    [self.iv setImageWithURL:[NSURL URLWithString:@""]];
    
    // 取消加载
    [self.iv cancelImageDownloadTask];
}

//url-request-session-task-resume
/*
 初始化：1.初始化session；2.设置很多默认值
 get:
 1.在生成request的时候处理了监听request的属性变化；
 2.参数转查询字符串；
 3.生成任务安全；
 4.通过AFURLSessionManagerTaskDelegate使得我们的进度可以通过block回调；
 5.通过AFURLSessionManagerTaskDelegate拼接我们的服务器返回数据
 */
- (ViewController *)get{
  
    NSString *urlStr = @"https://api.douban.com/v2/movie/top250";
    NSDictionary *dic = @{@"start":@(1),
                          @"count":@(5)
                          };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:urlStr parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    NSLog(@"get");
    
    return self;
}


- (void)method {
    NSLog(@"1111");
}

@end
