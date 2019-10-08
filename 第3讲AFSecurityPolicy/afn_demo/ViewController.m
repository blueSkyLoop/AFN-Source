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
/*
 1.发起请求：urlsessionmanager 减少了主类的复杂度，提高维护
 2.请求过程 delegate
 3.请求完成 delegate
 
 系统原生的进度是通过代理
 af提供了block
 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}
- (void)testBD{
    NSString *urlstr = @"https://www.baidu.com/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success--%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail--%@",error);
        
    }];
}
// challeng ---> 发起更新cer

- (void)test{
    
    // afn clinet --  manager + rac
    // CA
    // 免费：自签
    // cer -- baidu
    // openSSL 509 .crt -- .cer
    // https 加密方式 ： 非对称+对称
    // 非对称：
    // 自签证书处理
    
    NSString *urlstr = @"https://112.124.34.197:9000/users/bar";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 不安全 -- 授权
    manager.securityPolicy        = [self securityPolicy];
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success--%@",responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail--%@",error);

    }];
}


- (AFSecurityPolicy *)securityPolicy{
    
    // .crt --->.cer
    // 证书 ---> 公钥  ---> 随机数 加密
    //  项目本地导入  ---> 谁安装谁就能获取到这个证书
    //  证书：proy.
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    NSData   *data    = [NSData dataWithContentsOfFile:cerPath];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSSet    *cerSet  = [NSSet setWithObject:data];
    
    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
    [AFSecurityPolicy defaultPolicy];
    
    security.allowInvalidCertificates = YES;
    security.validatesDomainName      = NO;
    
    NSString *urlstr = @"https://112.124.34.197:9000/users/bar";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 不安全 -- 授权
    manager.securityPolicy        = [self securityPolicy];
    [manager GET:urlstr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success--%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail--%@",error);
        
    }];
    
    
    return security;
}


@end
