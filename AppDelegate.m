//
//  AppDelegate.m
//  MobileStation
//
//  Created by DS365 on 16/5/13.
//  Copyright © 2016年 MobileStation. All rights reserved.
//

#import "AppDelegate.h"
#import "COStyleFactory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [COStyleFactory applyStyle];
    [self setUpBaiMap];
    [self setNOTE];
    NSUserDefaults * stand=[NSUserDefaults standardUserDefaults];
    NSString * usekey=[stand objectForKey:USERKEY];
    if (usekey) {
        [self userLoginSuccess];
    }else
    {
        [self userLoginOutSuccess];
    }
    return YES;
}

-(void)setNOTE
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginSuccess) name:__USER_LOGIN_SUCCESS object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginOutSuccess) name:__USER_LOGINOUT_SUCCESS object:nil];
}
-(void)userLoginSuccess
{
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [login instantiateViewControllerWithIdentifier:@"CONAVController"];
    [self.window makeKeyAndVisible];
}
-(void)userLoginOutSuccess
{
    UIStoryboard *login = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    self.window.rootViewController = [login instantiateInitialViewController];
    [self.window makeKeyAndVisible];
}
-(void)setUpBaiMap{
    //百度地图
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"rzuLybbdLq8NMcA9sUHlF3Oex9y5aUMO"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
