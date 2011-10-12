//
//  TestView.h
//  DMValidationFramework
//
//  Created by Martin Stolz on 09/10/2011.
//  Copyright (c) 2011 devmob. All rights reserved.
//

//
//  A simple test view containing sample validator text fields.
//  The kind validator of validator is set in the controller. 
//

#import <Foundation/Foundation.h>
#import "DMValidatorTextField.h"


@interface TestView : UIView
{
    DMValidatorTextField *_validatorTextField1;
    DMValidatorTextField *_validatorTextField2;
    DMValidatorTextField *_validatorTextField3;
    DMValidatorTextField *_validatorTextField4;
}

@property (nonatomic, retain, readonly) DMValidatorTextField *validatorTextField1;
@property (nonatomic, retain, readonly) DMValidatorTextField *validatorTextField2;
@property (nonatomic, retain, readonly) DMValidatorTextField *validatorTextField3;
@property (nonatomic, retain, readonly) DMValidatorTextField *validatorTextField4;


@end
