//
//  WBHJSCameraController.m
//  WBHLearnToSummarize
//
//  Created by hjy on 2017/12/13.
//  Copyright © 2017年 baohong. All rights reserved.
//

#import "WBHJSCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <Photos/Photos.h>
#import "UIImage+WBHBase64.h"

@interface WBHJSCameraController ()<UINavigationControllerDelegate,UIWebViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
//
@property (nonatomic,strong)UIWebView * webView;

//
@property (nonatomic,strong)JSContext * jsContext;
//
@property (nonatomic,strong)UIImage * photo;
@property (nonatomic,copy) NSString  * base64;
//
@property (nonatomic,strong)UIWindow * window;
@end

@implementation WBHJSCameraController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self show];

}
-(void)dealloc{
    [self dismis];
}
-(void)show{
    _window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 80)];
    _window.backgroundColor = [UIColor clearColor];
    _window.windowLevel = UIWindowLevelAlert;
     [_window makeKeyAndVisible];
    _window.hidden = NO;
    [_window addSubview:self.webView];
    [_window bringSubviewToFront:self.window];
 
}

-(void)dismis{
    _window.hidden = YES;
    _window = nil;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"iosDelegate"] = self;
    __weak typeof(self) weakSelf = self;
    self.jsContext[@"SwitchCamera"] = ^(NSInteger parameter){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (parameter == 1) {
                [weakSelf openCamera];
            }else{
                [weakSelf closeCamera];
            }
        });
    };
}

//打开相机
-(void)openCamera{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        [self showCameraAlert];
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                JSValue * jsValue = self.jsContext[@"getSwitchCameraResult"];
                [jsValue callWithArguments:@[@"1"]];
            });
            
            [self presentViewController:self.imagePickerController animated:NO completion:nil];
        }else{
            NSLog(@"该设备没有相机");
        }
    }
}
-(void)closeCamera{
    [self.imagePickerController dismissViewControllerAnimated:NO completion:^{
//        [self dismisWindow];
        dispatch_async(dispatch_get_main_queue(), ^{
            JSValue *jsValue = self.jsContext[@"getSwitchCameraResult"];
            [jsValue callWithArguments:@[@"0"]];
        });
    }];
}



-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:[UIApplication sharedApplication].delegate.window.bounds];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.bouncesZoom = NO;
        NSURL * fileUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
        NSData * data = [NSData dataWithContentsOfURL:fileUrl];
        [_webView loadData:data MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:fileUrl];
        if (@available(iOS 11.0, *)) {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _webView;
}
//imagePickerController懒加载
-(UIImagePickerController *)imagePickerController{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc]init];
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = NO;
        _imagePickerController.showsCameraControls = NO;
        _imagePickerController.toolbarHidden = YES;
        _imagePickerController.navigationBarHidden = YES;
        _imagePickerController.cameraViewTransform = CGAffineTransformMakeScale(1.25, 1.25);
        CGSize screenBounds = [UIScreen mainScreen].bounds.size;
        CGFloat cameraAspectRatio = 4.0f / 3.0f;
        CGFloat camViewHeight =  screenBounds.width * cameraAspectRatio;
        CGFloat scale = screenBounds.height / camViewHeight;
        _imagePickerController.cameraViewTransform = CGAffineTransformMakeTranslation(0, (screenBounds.height - camViewHeight) / 2.0);
        _imagePickerController.cameraViewTransform = CGAffineTransformScale(_imagePickerController.cameraViewTransform, scale, scale);
    }
    return _imagePickerController;
}


//相机弹框
-(void)showCameraAlert{
    UIAlertController * alertViewController = [UIAlertController alertControllerWithTitle:@"相机权限未开启" message:@"相机权限未开启，请进入系统【设置】>【隐私】>【相机】中打开开关, 开启相机功能" preferredStyle:UIAlertControllerStyleAlert];
    [alertViewController addAction:[UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    [self presentViewController:alertViewController animated:YES completion:NULL];
}

//照片弹框
-(void)showAlbumAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"照片权限未开启" message:@"相机权限未开启，请进入系统【设置】>【隐私】>【照片】中打开开关, 开启相机功能" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"立即开启" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }]];
    [self presentViewController:alertController animated:YES completion:NULL];
    
}


@end
