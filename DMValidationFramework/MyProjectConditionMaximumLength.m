//
//  MyProjectConditionMaximumLength.m
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

#import "MyProjectConditionMaximumLength.h"


@implementation MyProjectConditionMaximumLength


- (id)init
{
    self = [super init];
    if (self)
    {
        _range = NSMakeRange(0, 8);
    }
    
    return self;
}


#pragma mark - Allow violation

- (BOOL)allowViolation
{
    return NO;
}


#pragma mark - Localized

- (NSString *)localizedViolationString
{
    return @"Too long, not more than 8 characters!";
}


@end
