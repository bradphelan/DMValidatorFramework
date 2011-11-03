//
//  DMValidator.m
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

#import "DMValidator.h"
#import "DMCondition.h"
#import "DMConditionCollection.h"


@implementation DMValidator


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _conditionCollection = [[DMConditionCollection alloc] init];
    }
    
    return self;
}


#pragma mark - Deinitialization

- (void)dealloc
{
    [_conditionCollection release];
    
    [super dealloc];
}


#pragma mark - Condition

/**
 * Add condition for validation queue.
 */
- (void)addCondition:(id<DMCondition>)condition
{
    if ([condition isKindOfClass:[DMCondition class]])
        [_conditionCollection addCondition:condition];
    else
        [NSException raise:NSGenericException format:[NSString stringWithFormat:@"Added incompatible condition <%@> to validator.", [condition class]]];
}

/**
 * Remove all conditions which are kind of specific class.
 */
- (void)removeConditionOfClass:(id<DMCondition>)conditionClass
{
    for (DMCondition *condition in _conditionCollection)
    {
        if ([condition isKindOfClass:(id)conditionClass])
            [_conditionCollection removeCondition:condition];
    }
}


#pragma mark - Condition check

/**
 * Returns all violated condition in a DMConditionCollection
 */
- (DMConditionCollection *)checkConditions:(NSString *)string
{
    DMConditionCollection *violatedConditions = nil;
    for (DMCondition *condition in _conditionCollection)
    {
        if (NO == [condition check:string])
        {
            if (nil == violatedConditions)
                violatedConditions = [[DMConditionCollection alloc] init];
            
            [violatedConditions addCondition:condition];
        }
    }
    
    return [violatedConditions autorelease];
}


@end
