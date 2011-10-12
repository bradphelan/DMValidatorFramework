//
//  AppDelegate.h
//  DMValidationFramework
//
//  Created by Martin Stolz on 07/10/2011.
//  Copyright (c) 2011 devmob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow           *_window;
    TestViewController *_testViewController;
}

@property (strong, nonatomic) UIWindow *window;


@end
