//
//  WBHNavigationController.m
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/12.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import "WBHNavigationController.h"

@interface WBHNavigationController ()

@end

@implementation WBHNavigationController

+(void)load{
    NSLog(@"%s",__func__);
}
+(void)initialize{
    NSLog(@"%s",__func__);
    // 在info.plist 中 View controller-based status bar appearance 设置为NO
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    [nav.navigationBar setBackgroundImage:[KMTools createImageWithColor:ThemeColor] forBarMetrics:UIBarMetricsDefault];
//    [nav.navigationBar setShadowImage:[KMTools createImageWithColor:ThemeColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor hx_colorWithHexRGBAString:@"22c5c0"]];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    //  关闭透明，无穿透效果
    [[UINavigationBar appearance] setTranslucent:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
}



@end
