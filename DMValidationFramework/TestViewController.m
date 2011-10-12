//
//  TestViewController.m
//  DMValidationFramework
//
//  Created by Martin Stolz on 07/10/2011.
//  Copyright (c) 2011 devmob. All rights reserved.
//

//
//  A simple test view controller which creates a test view with some
//  sample validation text fields on it.
//  This controller sets the properties of all created validator text fields.
//  When text inputs are violating the configured conditions (DMCondition)
//  the delegate instance will receive this information.
//

#import "TestViewController.h"
#import "DMCondition.h"
#import "DMValidatorTextField.h"
#import "DMValidatorNumeric.h"
#import "DMValidatorEmail.h"
#import "MyProjectValidatorPassword.h"


@interface TestViewController (private)
- (void)buildView;
- (void)initUserInterface;
@end


@implementation TestViewController


#pragma mark - Initialization

- (id)init
{
    self = [super init];
    
    return self;
}


#pragma mark - Deinitialization

- (void)dealloc
{
    [super dealloc];
}


#pragma mark - View setter and getter

- (void)setTestView:(TestView*)view
{
    self.view = view;
}

- (TestView*)testView
{
    return (TestView*)self.view;
}


#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    [self buildView];
}

/**
 * Build custom view with test validator text fields added
 */
- (void)buildView
{
    self.testView = [[[TestView alloc] initWithFrame: self.view.frame] autorelease];
}

/**
 * Initialize the UI components after view did load
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUserInterface];
}


#pragma mark - Rotation

/**
 * Allow rotation
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark - Initialization of view

/**
 * Initialize the UI and register interest for some changes
 */
- (void)initUserInterface
{    
    // Set properties of validator text field #1
    // Set the numeric validator to text field #1
    self.testView.validatorTextField1.validator      = [[DMValidatorNumeric alloc] init];
    self.testView.validatorTextField1.allowViolation = NO;
    self.testView.validatorTextField1.delegate       = self;
    
    // Set initial test value to test validator text field #2
    self.testView.validatorTextField2.validator      = [[DMValidatorEmail alloc] init];
    self.testView.validatorTextField2.allowViolation = YES;
    self.testView.validatorTextField2.delegate       = self;
    self.testView.validatorTextField2.text = @"test@devmob.";
    
    // Validate the text field #2 manually after adding text
    [self.testView.validatorTextField2 validate];
    
    // Set initial test value to test validator text field #3
    self.testView.validatorTextField3.validator            = [[DMValidatorNumeric alloc] init];
    self.testView.validatorTextField3.allowViolation       = YES;
    self.testView.validatorTextField3.validateAfterEditing = YES;
    
    // Set project specific properties of validator text field #4
    self.testView.validatorTextField4.validator      = [[MyProjectValidatorPassword alloc] init];
    self.testView.validatorTextField4.allowViolation = YES;
}


#pragma mark - Validator text field protocol

/**
 * Called for every change in validator text fields.
 * This method is now called via delegate and not NSNotification like standard iOS.
 */
- (void)validatorTextFieldDidChange:(DMValidatorTextField *)validatorTextField
{
}

/**
 * Allow every text field to be edited. Default is YES.
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

/**
 * Called for every valid or violated state change
 * React to this information by showing up warnings or disabling a 'send' button e.g.
 */
- (void)validatorTextField:(DMValidatorTextField *)validatorTextField changedValidState:(BOOL)isValid
{
    NSLog(@"validatorTextField changedValidState: %d", isValid);
}

/**
 * Called on every violation of the highest prioritised validator condition.
 * Update UI like showing alert messages or disabling buttons.
 */
- (void)validatorTextField:(DMValidatorTextField *)validatorTextField violatedCondition:(DMCondition *)condition
{
    NSString *violatedConditionString = [condition localizedViolationString];
    NSLog(@"validatorTextField violatedCondition: %@ %@", condition, violatedConditionString);
}


@end
