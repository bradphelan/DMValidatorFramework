//
//  ConditionUnitTests.m
//  DMValidationFrameworkUnitTests
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

#import "ConditionUnitTests.h"
#import "DMConditionNumeric.h"
#import "DMConditionRange.h"


@implementation ConditionUnitTests


- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

/**
 * Test DMConditionNumeric check
 */
- (void)testDMConditionNumeric
{
    NSString *successTestString1 = @"1234567890";
    NSString *failureTestString1 = @"a";
    
    // Does this come into setUp?
    DMConditionNumeric *condition = [[DMConditionNumeric alloc] init];
    STAssertTrue([condition check:successTestString1], @"The DMConditionNumeric should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The DMConditionNumeric should respond with FALSE and not TRUE", nil);
}

/**
 * Test DMConditionRange check
 */
- (void)testDMConditionRange
{
    NSString *successTestString1 = @"1A2B3D4C5D";
    NSString *successTestString2 = @"1A2";
    NSString *failureTestString1 = @"1A";
    
    DMConditionRange *condition = [[DMConditionRange alloc] init];
    condition.range = NSMakeRange(3, 10);
    STAssertTrue([condition check:successTestString1], @"The DMConditionRange should respond with TRUE and not FALSE", nil);
    STAssertTrue([condition check:successTestString2], @"The DMConditionRange should respond with TRUE and not FALSE", nil);
    
    STAssertFalse([condition check:failureTestString1], @"The DMConditionRange should respond with FALSE and not TRUE", nil);
}


@end
