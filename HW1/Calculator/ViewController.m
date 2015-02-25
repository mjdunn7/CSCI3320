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
@property (nonatomic) BOOL dotAlreadyTyped;

@end


@implementation ViewController

@synthesize display;
@synthesize keysPressed;
@synthesize userInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize dotAlreadyTyped = _dotAlreadyTyped;

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
        if (!(_dotAlreadyTyped && [digit isEqualToString:@"."]))
        {
            self.display.text = [self.display.text stringByAppendingString:digit];

        }
        
        if ([digit isEqualToString:@"."])
        {
            _dotAlreadyTyped = YES;
        }

    }
    
    else
    {
        if ([digit isEqualToString:@"."])
        {
            _dotAlreadyTyped = YES;
        }
        
        self.display.text = digit;
        self.userInTheMiddleOfEnteringANumber = YES;
    }
    
    
}

- (IBAction)enterPressed
{
    //Gets rid of "=" if present so that display can be sent to brain
    if ([[self.display.text substringToIndex:1] isEqualToString:@"="])
    {
        self.display.text = [self.display.text substringFromIndex:1];
    }
    
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userInTheMiddleOfEnteringANumber = NO;
    self.dotAlreadyTyped = NO;
    
    if ([self.display.text length] > 19)
    {
        self.keysPressed.text = self.display.text;
    }
    
    else if ([self.keysPressed.text length] > 19)
    {
        
        self.keysPressed.text = [self.keysPressed.text substringFromIndex:MAX(([self.display.text length]+4),0)];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:self.display.text];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:@" "];
    }
    
    else
    {
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:self.display.text];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:@" "];
    }
}


- (IBAction)operationPressed:(id)sender
{
    if (self.userInTheMiddleOfEnteringANumber)
    {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    
    if([self.keysPressed.text length] > 19)
    {
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:@" "];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:operation];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:@" "];
        self.keysPressed.text = [self.keysPressed.text substringFromIndex:4];
    }
    else
    {
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:@" "];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:operation];
        self.keysPressed.text = [self.keysPressed.text stringByAppendingString:@" "];
    }
    
    double result = [self.brain performOperation:operation];
    self.display.text = @"=";
    self.display.text = [self.display.text stringByAppendingString:[NSString stringWithFormat:@"%g", result]];
}

- (IBAction)clearPressed
{
    self.keysPressed.text = @" ";
    self.display.text = @"0";
    
    [self.brain clearStack];
    
    self.userInTheMiddleOfEnteringANumber = NO;
    
}


- (IBAction)backSpacePressed
{
    if ([[self.display.text substringToIndex:1] isEqualToString:@"="])
    {
        self.display.text = [self.display.text substringFromIndex:1];
    }
    
    if ([self.display.text length] > 1)
    {
        self.display.text = [self.display.text substringToIndex:MIN(([self.display.text length]-1),[self.display.text length])];
    }
   
    else
    {
        self.display.text = @"0";
        self.userInTheMiddleOfEnteringANumber = NO;
    }
}

- (IBAction)sighnPressed
{
    if ([[self.display.text substringToIndex:1] isEqualToString:@"="])
    {
        self.display.text = [self.display.text substringFromIndex:1];
    }
    
    
    if ([[self.display.text substringToIndex:1] isEqualToString:@"-"])
    {
        self.display.text = [self.display.text substringFromIndex:1];
    }
        
    else
    {
        NSString *tempString = @"-";
        self.display.text = [tempString stringByAppendingString:self.display.text];
    }
    
}

@end
