//
//  DMConditionCollection.m
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

#import "DMConditionCollection.h"


@implementation DMConditionCollection


@dynamic count;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _array  = [NSMutableArray new];
    }
    
    return self;
}

- (void)dealloc
{
    [_array release];
    
    [super dealloc];
}


#pragma mark - Manipulation

- (void)addCondition:(id<DMCondition>)condition
{
    [_array addObject:condition];
}

- (void)removeCondition:(id<DMCondition>)condition
{
    [_array removeObject:condition];
}

- (void)removeConditionAtIndex:(NSUInteger)index
{
    [_array removeObjectAtIndex:index];
}

- (DMCondition *)conditionAtIndex:(NSUInteger)index
{
    return [_array objectAtIndex:index];
}


#pragma mark - Fast enumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [_array countByEnumeratingWithState:state objects:buffer count:len];
}


#pragma mark - Information

- (NSUInteger)count
{
    return _array.count;
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
    for (DMCondition *condition in _array)
        [description appendString:condition.description];
    
    return description;
}


@end
