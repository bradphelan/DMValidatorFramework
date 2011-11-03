//
//  DMValidatorTextField.h
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

#import <UIKit/UIKit.h>
#import "DMValidator.h"


#pragma mark - Validator text field protocol

@protocol DMValidatorTextFieldDelegateDelegate;

@class DMValidatorTextField;
@class DMValidatorTextFieldDelegate;


@protocol DMValidatorTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)validatorTextFieldDidChange:(DMValidatorTextField *)validatorTextField;
- (void)validatorTextField:(DMValidatorTextField *)validatorTextField changedValidState:(BOOL)isValid;
- (void)validatorTextField:(DMValidatorTextField *)validatorTextField violatedConditions:(DMConditionCollection *)conditions;

@end


#pragma mark - Validator text field delegate delegate

@protocol DMCondition;


@protocol DMValidatorTextFieldDelegateDelegate <NSObject>

- (void)validatorTextFieldDelegate:(DMValidatorTextFieldDelegate*)delegate violatedConditions:(DMConditionCollection *)conditions;
- (void)validatorTextFieldDelegateSuccededConditions:(DMValidatorTextFieldDelegate*)delegate;

@end


#pragma mark - Validator text field interface

@interface DMValidatorTextField : UITextField <UITextFieldDelegate, DMValidatorTextFieldDelegateDelegate>
{
@private
    id<DMValidatorTextFieldDelegate> _originDelegate;
    DMValidator                      *_validator;
    DMValidatorTextFieldDelegate     *_validatorTextFieldDelegate;
    BOOL                             _allowViolation;
    BOOL                             _validateAfterEditing;
    BOOL                             _didEndEditing;
    UIColor                          *_validTextColor;
    UIColor                          *_invalidTextColor;
}

/**
 * Set delegate implementing DMValidatorTextFieldDelegate
 */
@property (nonatomic, assign) id<DMValidatorTextFieldDelegate> delegate;

/**
 * Set the validator to check the text of the text field with
 */
@property (nonatomic, retain) DMValidator *validator;

/**
 * Determines whether text inputs can be made either by violating the conditions.
 * Is this parameter NO it overrides the 'allowViolation' parameter of 
 * the conditions added to the validator. If set to YES the 'allowViolation'
 * parameters of the conditions considered.
 */
@property (nonatomic, assign) BOOL allowViolation;

/**
 * Return whether the text is valid.
 *
 * @return Returns the valid state of the text field
 */
@property (nonatomic, assign, readonly) BOOL isValid;

/**
 * Determines whether the text has to be validated after leaving the text field
 * or while editing. After a violation appeared after leaving the text field
 * the text field will from now on validate while editing. Because the user
 * knows now that a violation occurrs when using this text field.
 */
@property (nonatomic, assign) BOOL validateAfterEditing;

/**
 * Set the color of the text on invalid state.
 */
@property (nonatomic, retain) UIColor *invalidTextColor;

/**
 * Validate text field manually.
 */
- (void)validate;


@end


#pragma mark -
#pragma mark - Validator text field delegate

#pragma mark - Validator text field interface

@interface DMValidatorTextFieldDelegate : NSObject <UITextFieldDelegate>
{
    id<DMValidatorTextFieldDelegate> _delegate;
    DMValidatorTextField             *_validatorTextField;
    BOOL                             _lastIsValid;
}

@property (nonatomic, retain) id<DMValidatorTextFieldDelegate> delegate;
@property (nonatomic, retain) DMValidatorTextField             *validatorTextField;


@end
