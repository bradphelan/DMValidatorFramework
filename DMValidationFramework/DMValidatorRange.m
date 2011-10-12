//
//  DMValidatorRange.m
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

#import "DMValidatorRange.h"
#import "DMConditionRange.h"


@implementation DMValidatorRange


@synthesize range = _range;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        DMConditionRange *rangeCondition = [[DMConditionRange alloc] init];
        [self addCondition:rangeCondition];
        [rangeCondition release];
    }
    
    return self;
}


#pragma mark - Range

- (void)setRange:(NSRange)range
{
    _range = range;
    
    // Remove all added range coniditons
    [self removeConditionOfClass:(id<DMCondition>)[DMConditionRange class]];
    
    // Add new range condition
    DMConditionRange *rangeCondition = [[DMConditionRange alloc] init];
    rangeCondition.range             = _range;
    [self addCondition:rangeCondition];
    [rangeCondition release];
}


@end
