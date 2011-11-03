//
//  DMCondition.m
//  DMValidationFramework
//
//  Copyright 2011 Martin Stolz
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "DMCondition.h"


@implementation DMCondition


@synthesize allowViolation = _allowViolation;


#pragma mark - Check

/**
 * Check the custom condition.
 *
 * @return Return whether condition check failed or not
 */
- (BOOL)check:(NSString *)string
{
    return YES;
}


#pragma mark - Localization

/**
 * Returns a localized violation string.
 *
 * @return Localized violation string
 */
- (NSString *)localizedViolationString
{
    return nil;
}


#pragma mark - Description

/**
 * Returns the description
 *
 * @return Description string
 */
- (NSString *)description
{
    NSMutableString *description = [[NSMutableString new] autorelease];
    [description appendString:@"<"];
    [description appendString:[super description]];
    [description appendString:[NSString stringWithFormat:@"\n <localizedViolationString: %@>", self.localizedViolationString]];
    [description appendString:[NSString stringWithFormat:@"\n <allowViolation: %@>", _allowViolation == 0 ? @"YES" : @"NO"]];
    [description appendString:@">"];
    
    return description;
}


@end
