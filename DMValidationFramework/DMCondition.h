//
//  DMCondition.h
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


#pragma mark - Condition protocol

@protocol DMCondition <NSObject>

@required

/**
 * Check the custom condition.
 *
 * @return Return whether condition check failed or not
 */
- (BOOL)check:(NSString *)string;

/**
 * Returns a localized violation string.
 *
 * @return Localized violation string
 */
- (NSString *)localizedViolationString;


@end


#pragma mark - Condition interface

@interface DMCondition : NSObject <DMCondition>
{
@private
    BOOL _allowViolation;
}

@property (nonatomic, assign) BOOL allowViolation;


@end
