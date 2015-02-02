//
//  ViewController.m
//  Calculator
//
//  Created by MacBook Pro on 1/31/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()

@property (nonatomic) BOOL userInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;

@end


@implementation ViewController

@synthesize display;
@synthesize userInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton*)sender
{
    NSString *digit = [sender currentTitle];
    
    if (self.userInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    
    else
    {
        self.display.text = digit;
        self.userInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userInTheMiddleOfEnteringANumber = NO;
}


- (IBAction)operationPressed:(id)sender
{
    if (self.userInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

@end
