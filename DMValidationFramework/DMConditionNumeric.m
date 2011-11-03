//
//  DMConditionNumeric.m
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

#import "DMConditionNumeric.h"


@implementation DMConditionNumeric


- (BOOL)check:(NSString *)string
{
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    return numberOfMatches == string.length;
}


#pragma mark - Allow violation

- (BOOL)allowViolation
{
    return YES;
}


#pragma mark - Localized

- (NSString *)localizedViolationString
{
    return NSLocalizedString(@"DMKeyConditionViolationNumeric", nil);
}


@end
