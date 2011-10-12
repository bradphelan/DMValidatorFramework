//
//  TestViewController.h
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

#import "TestView.h"


@interface TestViewController : UIViewController <DMValidatorTextFieldDelegate>
{
}

@property (nonatomic, retain, readonly) TestView* testView;


@end
