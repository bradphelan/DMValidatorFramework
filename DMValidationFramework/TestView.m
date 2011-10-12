//
//  TestView.m
//  DMValidationFramework
//
//  Created by Martin Stolz on 09/10/2011.
//  Copyright (c) 2011 devmob. All rights reserved.
//

//
//  A simple test view containing sample validator text fields.
//  The kind validator of validator is set in the controller. 
//

#import "TestView.h"


@interface TestView (private)
- (void)buildUserInterface;
@end


@implementation TestView


@synthesize validatorTextField1 = _validatorTextField1;
@synthesize validatorTextField2 = _validatorTextField2;
@synthesize validatorTextField3 = _validatorTextField3;
@synthesize validatorTextField4 = _validatorTextField4;


#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self buildUserInterface];
    }
    
    return self;
}


#pragma mark - Build user interface

/**
 * Create two test validator text fields on the view
 */
- (void)buildUserInterface
{
    // Set auto resizing
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Set background color of view
    self.backgroundColor = [UIColor lightGrayColor];
    
    // Add test validator text field #1
    CGRect textFieldFrame1                = CGRectMake(10.0, 2.0, self.frame.size.width - 20.0, 30.0);
    _validatorTextField1                  = [[DMValidatorTextField alloc] init];
    _validatorTextField1.frame            = textFieldFrame1;
    _validatorTextField1.backgroundColor  = [UIColor whiteColor];
    _validatorTextField1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _validatorTextField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _validatorTextField1.clearButtonMode  = UITextFieldViewModeAlways;
    [self addSubview:_validatorTextField1];
    [_validatorTextField1 release];
    
    // Add test validator text field #2
    CGRect textFieldFrame2                = CGRectMake(10.0, 36.0, self.frame.size.width - 20.0, 30.0);
    _validatorTextField2                  = [[DMValidatorTextField alloc] init];
    _validatorTextField2.frame            = textFieldFrame2;
    _validatorTextField2.backgroundColor  = [UIColor whiteColor];
    _validatorTextField2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _validatorTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_validatorTextField2];
    [_validatorTextField2 release];
    
    // Add test validator text field #3
    CGRect textFieldFrame3                = CGRectMake(10.0, 70.0, self.frame.size.width - 20.0, 30.0);
    _validatorTextField3                  = [[DMValidatorTextField alloc] init];
    _validatorTextField3.frame            = textFieldFrame3;
    _validatorTextField3.backgroundColor  = [UIColor whiteColor];
    _validatorTextField3.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _validatorTextField3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_validatorTextField3];
    [_validatorTextField3 release];
    
    // Add test validator text field #4
    CGRect textFieldFrame4                = CGRectMake(10.0, 104.0, self.frame.size.width - 20.0, 30.0);
    _validatorTextField4                  = [[DMValidatorTextField alloc] init];
    _validatorTextField4.frame            = textFieldFrame4;
    _validatorTextField4.backgroundColor  = [UIColor whiteColor];
    _validatorTextField4.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _validatorTextField4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addSubview:_validatorTextField4];
    [_validatorTextField4 release];
}


@end
