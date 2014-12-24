//
//  ViewController.m
//  GetDeviceIDDemo
//
//  Created by 冯啸波 on 12/24/2557 BE.
//  Copyright (c) 2557 BE 冯啸波. All rights reserved.
//

#import "ViewController.h"
#import "MobClick.h"
#define kWidth self.view.frame.size.width

@interface ViewController (){
    
}
@property (weak, nonatomic) IBOutlet UILabel *getDeviceIDLabel;
@property (weak, nonatomic) IBOutlet UIButton *getDeviceIDButton;
@property (weak, nonatomic) IBOutlet UIButton *upLoadButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _getDeviceIDLabel.numberOfLines = 0;
    [_getDeviceIDButton addTarget:self action:@selector(UMENGGetUUID) forControlEvents:UIControlEventTouchUpInside];
    [_upLoadButton addTarget:self action:@selector(upLoad) forControlEvents:UIControlEventTouchUpInside];
}

- (void)UMENGGetUUID{
    
    [MobClick startWithAppkey:@"547b3199fd98c528d2001098" reportPolicy:BATCH channelId:@"ios"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick updateOnlineConfig];

    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    
    NSString *deviceName = [[UIDevice currentDevice] name];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"{\"oid\": \"%@\"},deviceName = %@,systemVersion = %@",deviceID,deviceName,systemVersion);
}

- (void)upLoad{
    [self UMENGGetUUID];
    
    NSString *email =@"mailto:zhaoziyuan@xjimi.com";
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
