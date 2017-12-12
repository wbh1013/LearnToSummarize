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
#import "WBHNavigationController.h"
@interface WBHTabBarController ()

@end

@implementation WBHTabBarController


+(void)initialize{

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hx_colorWithHexRGBAString:@"#9a9795"],NSForegroundColorAttributeName,[UIFont systemFontOfSize:11],NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor hx_colorWithHexRGBAString:@"#22c5c0"], NSForegroundColorAttributeName,[UIFont systemFontOfSize:11],NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    //  tabBar的颜色
    [[UITabBar appearance] setBarTintColor:[UIColor hx_colorWithHexRGBAString:@"ffffff"]];
}

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
    WBHNavigationController * nav = [[WBHNavigationController alloc]initWithRootViewController:VC];
    
   
    nav.jz_fullScreenInteractivePopGestureEnabled = YES;

    [self addChildViewController:nav];
}



@end
