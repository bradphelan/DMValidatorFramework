//
//  DMValidatorTextField.m
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

#import "DMValidatorTextField.h"
#import "DMCondition.h"


@interface DMValidatorTextField (private)
- (void)startUp;
- (void)setInvalidMode;
- (void)setValidMode;
@end


@implementation DMValidatorTextField


@synthesize delegate             = _originDelegate;
@synthesize validator            = _validator;
@synthesize allowViolation       = _allowViolation;
@synthesize validateAfterEditing = _validateAfterEditing;
@synthesize invalidTextColor     = _invalidTextColor;
@dynamic    isValid;


#pragma mark - Initialization

- (id)init
{
	self = [super init];
	if (self != nil)
	{
        [self startUp];
	}
    
	return self;
}


#pragma mark - Deinitialization

- (void)dealloc
{
    self.validator = nil;
    
    [_validatorTextFieldDelegate release];
    
    [super dealloc];
}


#pragma mark - Start up

- (void)startUp
{
    // Allows violation initially
    _allowViolation = YES;
    
    // Validate immediately
    _validateAfterEditing = NO;
    
    // Text field did not end editing at start
    _didEndEditing = NO;
    
    // Create listening instance 
    _validatorTextFieldDelegate = [[DMValidatorTextFieldDelegate alloc] init];
    _validatorTextFieldDelegate.validatorTextField = self;
    super.delegate = (id)_validatorTextFieldDelegate;
    
    // Listen for update of inherited UITextField
    [[NSNotificationCenter defaultCenter] addObserver:_validatorTextFieldDelegate selector: @selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    
    // Listen for end of editing
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    // Set initial violation color
    self.invalidTextColor = [UIColor redColor];
}


#pragma mark - Delegate

/**
 * Setting delegate for retrieving changes of UITextField and DMValidatorTextField
 *
 * @param: Delegate implementing DMValidatorTextFieldDelegate
 */
- (void)setDelegate:(id<DMValidatorTextFieldDelegate>)delegate
{
    _validatorTextFieldDelegate.delegate = delegate;
}


#pragma mark - Set validator

- (void)setValidator:(DMValidator *)validator
{
    [_validator release];
    _validator = [validator retain];
}


#pragma mark - Set text color

- (void)setTextColor:(UIColor *)textColor
{
    _validTextColor = textColor;
    
    [super setTextColor:textColor];
}

- (UIColor *)textColor
{
    return _validTextColor;
}



#pragma mark - Is valid

- (BOOL)isValid
{
    return [_validator checkConditions:self.text] == nil;
}


#pragma mark - Validate

/**
 * Validate the text field and update the UI.
 */
- (void)validate
{
    DMConditionCollection *conditions = [_validator checkConditions:self.text];    
    if (conditions == nil)
        [self setValidMode];
    else
        [self setInvalidMode];
}


#pragma mark - 

/**
 * After occurring violations the UI will be changed.
 */
- (void)validatorTextFieldDelegate:(DMValidatorTextFieldDelegate*)delegate violatedConditions:(DMConditionCollection *)conditions
{
    // Show visual info about violation if text field was left or violation is not allowed
    if ((NO == _allowViolation
         || NO == [conditions conditionAtIndex:0].allowViolation)
        || YES == _didEndEditing
        || NO == _validateAfterEditing)
    {
        [self setInvalidMode];
    }
    
    // Hide visual info about violation after some time.
    if (NO == _allowViolation
        || NO == [conditions conditionAtIndex:0].allowViolation)
    {
        [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timerPassed:) userInfo:nil repeats:NO];
    }
}

/**
 * Hide visual info about violation after some time.
 */
- (void)timerPassed:(NSTimer *)timer
{
    [self setValidMode];
}

/**
 * The invalid mode changes the UI to invalid state.
 */
- (void)setInvalidMode
{
    _validTextColor = self.textColor;
    super.textColor = _invalidTextColor;
}

/**
 * The valid mode changes the UI to valid state.
 */
- (void)setValidMode
{
    super.textColor = _validTextColor;
}

/**
 * After the text of the text field turns into valid the UI will be changed back.
 */
- (void)validatorTextFieldDelegateSuccededConditions:(DMValidatorTextFieldDelegate*)delegate
{
    [self setValidMode];
}


/**
 * Validate text field after ending editing and show from now on the validation state
 *
 * @param: Instance of text field where editing ended
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // If set to yes the text field is allowed to react to violations
    _didEndEditing = YES;
    
    // Validate text field once after ending editing
    [self validate];
}


@end


#pragma mark -
#pragma mark - Validator text field delegate

@implementation DMValidatorTextFieldDelegate


@synthesize delegate           = _delegate;
@synthesize validatorTextField = _validatorTextField;


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if (self)
    {
        _lastIsValid = -1;
    }
    
    return self;
}


#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *futureString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    DMConditionCollection *conditions = [_validatorTextField.validator checkConditions:futureString];
    
    // Inform text field about valid state change
    if (conditions == nil)
        [_validatorTextField validatorTextFieldDelegateSuccededConditions:self];
    else
        [_validatorTextField validatorTextFieldDelegate:self violatedConditions:conditions];
    
    // If condition is NULL no condition failed
    if (NO == _validatorTextField.allowViolation
        || NO == [conditions conditionAtIndex:0].allowViolation)
    {
        return [conditions conditionAtIndex:0] == nil;
    }
    
    // Ask delegate whether should change characters in range
    if ([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [_delegate textField:_validatorTextField shouldChangeCharactersInRange:range replacementString:string];
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (YES == _validatorTextField.allowViolation)
    {
        DMConditionCollection *conditions = [_validatorTextField.validator checkConditions:_validatorTextField.text];
        BOOL isValid = conditions == nil;
        if (_lastIsValid != isValid)
        {
            _lastIsValid = isValid;
            
            // Inform text field about valid state change
            if (isValid)
                [_validatorTextField validatorTextFieldDelegateSuccededConditions:self];
            else
                [_validatorTextField validatorTextFieldDelegate:self violatedConditions:conditions];
            
            // Inform delegate about valid state change
            if ([_delegate respondsToSelector:@selector(validatorTextField:changedValidState:)])
                [_delegate validatorTextField:_validatorTextField changedValidState:isValid];
            
            // Inform delegate about violation
            if (!isValid)
            {
                if ([_delegate respondsToSelector:@selector(validatorTextField:violatedConditions:)])
                    [_delegate validatorTextField:_validatorTextField violatedConditions:conditions];
            }
        }
    }
    
    // Inform delegate about changes
    if ([_delegate respondsToSelector:@selector(validatorTextFieldDidChange:)])
        [_delegate validatorTextFieldDidChange:_validatorTextField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Ask delegate whether should begin editing
    if ([_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        return [_delegate textFieldShouldBeginEditing:_validatorTextField];
    
    return YES;
}


@end
