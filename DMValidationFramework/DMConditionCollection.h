//
//  DMConditionCollection.h
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
#import "DMCondition.h"


#pragma mark - Condition collection protocol

@class DMConditionCollection;

@protocol DMConditionCollection <NSObject>

@required

/**
 * Add a condition to collection.
 *
 * @param DMCondition instance to add
 */
- (void)addCondition:(id<DMCondition>)condition;

/**
 * Remove a condition from collection.
 *
 * @param DMCondition instance to remove
 */
- (void)removeCondition:(id<DMCondition>)condition;

/**
 * Remove a condition from collection at index.
 *
 * @param DMCondition instance to remove
 */
- (void)removeConditionAtIndex:(NSUInteger)index;

/**
 * Returns a condition of collection at index.
 *
 * @return Return DMCondition instance
 */
- (DMCondition *)conditionAtIndex:(NSUInteger)index;

/**
 * Returns an array of violated conditions
 *
 * @return Return DMCondition instance
 */
//- (DMConditionCollection *)violatedConditionsWithString:(NSString *)string;


@end


#pragma mark - Condition collection interface

@interface DMConditionCollection : NSObject <DMConditionCollection,
                                             NSFastEnumeration>
{
    NSMutableArray *_array;
}

@property (nonatomic, assign, readonly) NSUInteger count;


@end
