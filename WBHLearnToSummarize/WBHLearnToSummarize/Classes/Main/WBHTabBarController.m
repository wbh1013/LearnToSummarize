//
//  WBHTabBarController.m
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/12.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import "WBHTabBarController.h"
#import "WBHInterfaceController.h"
#import "WBHUtilityClassController.h"
@interface WBHTabBarController ()

@end

@implementation WBHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    //界面
    [self addChildVC:[[WBHInterfaceController alloc]init] titleString:@"界面" selectImage:@"Interface_select" normalImage:@"Interface_nomal"];
    [self addChildVC:[[WBHUtilityClassController alloc] init] titleString:@"工具类" selectImage:@"UtilityClass_select" normalImage:@"UtilityClass_normal"];
    
}

-(void)addChildVC:(UIViewController *)VC  titleString:(NSString *)titleString selectImage:(NSString *)selectImage normalImage:(NSString *)normalImage {
    VC.title = titleString;
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.image = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    [[UINavigationBar appearance] setBarTintColor:[UIColor hx_colorWithHexRGBAString:@"006633"]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //  关闭透明，无穿透效果
    [[UINavigationBar appearance] setTranslucent:NO];
    nav.jz_fullScreenInteractivePopGestureEnabled = YES;
//    [nav.navigationBar setBackgroundImage:[KMTools createImageWithColor:ThemeColor] forBarMetrics:UIBarMetricsDefault];
//    [nav.navigationBar setShadowImage:[KMTools createImageWithColor:ThemeColor]];
    [self addChildViewController:nav];
}



@end
