//
//  AppDelegate.m
//  Oye5
//
//  Created by Rita Kyauk on 2/21/16.
//  Copyright © 2016 Oye5. All rights reserved.
//

@import AFNetworking;

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

#import "AppDelegate.h"
#import "OYELogFormatter.h"
#import "OYEUserManager.h"

#import "UIColor+Extensions.h"

@interface UITextField (Appearances)

- (void)setLayerCornerRadius:(CGFloat)cornerRadiu;

@end

@implementation UITextField (Appearances)

- (void)setLayerCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setLayerBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setLayerBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = 1;
}

@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupLogger];
    [self setupAFNetworking];
    [self setupUser];
    [self setupAppearances];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
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
    
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {

    return [[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]]
            || [[FBSDKApplicationDelegate sharedInstance] application:application
                                                              openURL:url
                                                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [[GIDSignIn sharedInstance] handleURL:url
//                               sourceApplication:sourceApplication
//                                      annotation:annotation]
//            || [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                              openURL:url
//                                                    sourceApplication:sourceApplication
//                                                           annotation:annotation];
//}

#pragma mark - Private

- (void)setupLogger {
    [DDASLLogger sharedInstance].logFormatter = [OYELogFormatter new];
    [DDTTYLogger sharedInstance].logFormatter = [OYELogFormatter new];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDLogDebug(@"*");
}

- (void)setupAFNetworking {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)setupUser {
    [[OYEUserManager sharedManager] setup];
}

- (void)setupAppearances {
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setBorderStyle:UITextBorderStyleNone];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setLayerCornerRadius:1.0];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setLayerBorderColor:[UIColor oyeLightGrayBackgroundColor]];
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setLayerBorderWidth:1.0];
}

@end
