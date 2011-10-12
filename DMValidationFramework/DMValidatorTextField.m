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
@synthesize violationColor       = _violationColor;
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
    self.validator      = nil;
    self.violationColor = nil;
    
    [_validatorTextFieldDelegate release];
    
    [super dealloc];
}


#pragma mark - Start up

- (void)startUp
{
    // Remember whether text field was layouted once
    _wasLayouted = NO;
    
    // Allows violation initially
    _allowViolation = YES;
    
    // Validate immediately
    _validateAfterEditing = NO;
    
    // Text field did not end editing at start
    _didEndEditing = NO;
    
    self.clipsToBounds = NO;
    
    // Create listening instance 
    _validatorTextFieldDelegate = [[DMValidatorTextFieldDelegate alloc] init];
    _validatorTextFieldDelegate.validatorTextField = self;
    super.delegate = (id)_validatorTextFieldDelegate;
    
    // Listen for update of inherited UITextField
    [[NSNotificationCenter defaultCenter] addObserver:_validatorTextFieldDelegate selector: @selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    
    // Listen for end of editing
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:self];
    
    // Set initial background color
    self.backgroundColor = [UIColor whiteColor];
    
    // Set initial violation color
    self.violationColor = [UIColor redColor];
}

/**
 * Due to there is no known chance of creating a border which is animatable
 * this approach adds a 'violation view' which marks the violation visually.
 * Due to the ordering of the views in iOS a new text view must be added as
 * the new background.
 * The 'textInputView' bounds are set once avoiding a loop of 'layoutSubiviews'
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat borderWidth = 2.0f;
    if (_wasLayouted == NO)
    {
        _wasLayouted = YES;

        // Add violation view which marks the violation as a border
        _violationView = [[UIView alloc] init];
        _violationView.backgroundColor = _theBackgroundColor;
        _violationView.userInteractionEnabled = NO;
        [self insertSubview:_violationView atIndex:0];
        [_violationView release];
        
        self.textInputView.bounds = CGRectMake(borderWidth,
                                               borderWidth,
                                               self.bounds.size.width - borderWidth * 2,
                                               self.bounds.size.height - borderWidth * 2);
        
        // Add text view which works as the new background
        _textView                 = [[UIView alloc] init];
        _textView.backgroundColor = _theBackgroundColor;
        _textView.userInteractionEnabled = NO;
        [_violationView addSubview:_textView];
        [_textView release];
    }
    
    _violationView.frame = CGRectMake(0.0,
                                      0.0,
                                      self.bounds.size.width + borderWidth * 2,
                                      self.bounds.size.height + borderWidth * 2);
    
    _textView.frame = self.textInputView.bounds;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _theBackgroundColor = backgroundColor;
    super.backgroundColor = backgroundColor;
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
    DMCondition *condition = [_validator checkConditions:self.text];    
    if (condition == nil)
        [self setValidMode];
    else
        [self setInvalidMode];
}


#pragma mark - 

/**
 * After occurring violations the UI will be changed.
 */
- (void)validatorTextFieldDelegate:(DMValidatorTextFieldDelegate*)delegate violatedCondition:(DMCondition *)condition
{
    if ((NO == _allowViolation
         || NO == [condition allowViolation])
        || YES == _didEndEditing
        || NO == _validateAfterEditing)
    {
        [self setInvalidMode];
    }
    
    if (NO == _allowViolation
        || NO == [condition allowViolation])
    {
        [UIView animateWithDuration:0.1f
                              delay:0.5f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             _violationView.backgroundColor = _theBackgroundColor;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

/**
 * The invalid mode changes the UI to invalid state.
 */
- (void)setInvalidMode
{
    [UIView animateWithDuration:0.1f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _violationView.backgroundColor = _violationColor;
                     }
                     completion:^(BOOL finished) {
                     }];
}

/**
 * The valid mode changes the UI to valid state.
 */
- (void)setValidMode
{
    [UIView animateWithDuration:0.1f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _violationView.backgroundColor = self.backgroundColor;
                     }
                     completion:^(BOOL finished) {
                     }];
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
    DMCondition *condition = [_validatorTextField.validator checkConditions:futureString];
    
    // Inform text field about valid state change
    if (condition == nil)
        [_validatorTextField validatorTextFieldDelegateSuccededConditions:self];
    else
        [_validatorTextField validatorTextFieldDelegate:self violatedCondition:condition];
    
    // If condition is NULL no condition failed
    if (NO == _validatorTextField.allowViolation
        || NO == [condition allowViolation])
    {
        return condition == nil;
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
        DMCondition *condition = [_validatorTextField.validator checkConditions:_validatorTextField.text];
        BOOL isValid = condition == nil;
        if (_lastIsValid != isValid)
        {
            _lastIsValid = isValid;
            
            // Inform text field about valid state change
            if (isValid)
                [_validatorTextField validatorTextFieldDelegateSuccededConditions:self];
            else
                [_validatorTextField validatorTextFieldDelegate:self violatedCondition:condition];
            
            // Inform delegate about valid state change
            if ([_delegate respondsToSelector:@selector(validatorTextField:changedValidState:)])
                [_delegate validatorTextField:_validatorTextField changedValidState:isValid];
            
            // Inform delegate about violation
            if (!isValid)
            {
                if ([_delegate respondsToSelector:@selector(validatorTextField:violatedCondition:)])
                    [_delegate validatorTextField:_validatorTextField violatedCondition:condition];
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