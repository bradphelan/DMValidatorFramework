//
//  AppDelegate.m
//  DMValidationFramework
//
//  Created by Martin Stolz on 07/10/2011.
//  Copyright (c) 2011 devmob. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate


@synthesize window = _window;


- (void)dealloc
{
    [_testViewController release];
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    _testViewController = [[TestViewController alloc] init];
    [self.window addSubview:_testViewController.view];
    
    return YES;
}


@end
