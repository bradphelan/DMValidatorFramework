//
//  DMConditionRange.h
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

/**
 * The DMConditionRange validates the length of a string.
 *
 * Usage:
 *
 * NSString *testString = @"a valid string";
 *
 * DMConditionRange *rangeCondition = [[DMConditionRange alloc] init];
 * rangeCondition.range = NSMakeRange(3, 12);
 *
 * DMValidator *rangeValidator = [[DMValidator alloc] init];
 * [rangeValidator addCondition:rangeCondition];
 * [rangeCondition release];
 *
 * BOOL isValid = [rangeValidator checkConditions:testString] == nil;
 *
 */

#import <Foundation/Foundation.h>
#import "DMCondition.h"


@interface DMConditionRange : DMCondition
{
    NSRange _range;
}

@property (nonatomic, assign) NSRange range;


@end
