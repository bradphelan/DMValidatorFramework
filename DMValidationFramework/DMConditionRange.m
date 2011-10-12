//
//  DMConditionRange.m
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

#import "DMConditionRange.h"


@implementation DMConditionRange


@synthesize range = _range;


- (id)init
{
    self = [super init];
    if (self)
    {
        _range = NSMakeRange(0, 15);
    }
    
    return self;
}


#pragma mark - Violation check

- (BOOL)check:(NSString *)string
{
    NSError *error             = NULL;
    NSString* regexString      = [NSString stringWithFormat:@"^.{%d,%d}$", _range.location, _range.length];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:0 error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    return numberOfMatches > 0;
}


#pragma mark - Localized

- (NSString *)localizedViolationString
{
    return [NSString stringWithFormat:NSLocalizedString(@"keyConditionViolationRange", nil), _range.location, _range.length];
}


@end
