//
//  DMBaseCondition.m
//  DMValidationFramework
//
//  Created by Martin Stolz on 07/10/2011.
//  Copyright (c) 2011 devmob. All rights reserved.
//

#import "DMBaseCondition.h"


@implementation DMBaseCondition


/**
 * Override this method and create custom condition.
 */
+ (BOOL)check:(NSString*)string
{
    return YES;
}


@end
