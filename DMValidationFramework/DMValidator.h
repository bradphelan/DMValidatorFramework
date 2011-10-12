//
//  DMValidator.h
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

#import <Foundation/Foundation.h>


#pragma mark - Base validator protocol

@protocol DMCondition;
@class    DMCondition;


@protocol DMValidator <NSObject>

/**
 * Add condition subclass of DMCondition for validation queue.
 *
 * @param: Condition subclass of DMCondition
 */
- (void)addCondition:(DMCondition *)condition;

/**
 * Remove all conditions subclassing conditionClass from validation queue.
 *
 * @param: Condition class subclass of DMCondition
 */
- (void)removeConditionOfClass:(id<DMCondition>)conditionClass;

/**
 * Add condition subclass of DMCondition for validation queue.
 *
 * @return: Returns whether all conditions were successful.
 */
- (DMCondition *)checkConditions:(NSString*)string;

@end


#pragma mark - Base validator interface

@interface DMValidator : NSObject <DMValidator>
{
@private
    NSMutableArray *_conditions;
}


@end