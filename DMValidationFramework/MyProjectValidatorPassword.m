//
//  MyProjectValidatorPassword.m
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

#import "MyProjectValidatorPassword.h"
#import "MyProjectConditionPassword.h"
#import "MyProjectConditionMaximumLength.h"
#import "DMConditionRange.h"


@implementation MyProjectValidatorPassword


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        // Use DMConditionRange or override with custom condition class
        // like MyProjectConditionMaximumLength
        
        /*
        DMConditionRange* rangeCondition = [[[DMConditionRange alloc] init] autorelease];
        rangeCondition.range             = NSMakeRange(0, 10);
        rangeCondition.allowViolation    = NO;
        [self addCondition:rangeCondition];
         */
        
        // Add conditions, first added has highest priority
        [self addCondition:[[[MyProjectConditionMaximumLength alloc] init] autorelease]];
        [self addCondition:[[[MyProjectConditionPassword alloc] init] autorelease]];
    }
    
    return self;
}


@end
