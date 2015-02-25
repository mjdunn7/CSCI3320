//
//  CalculatorBrain.m
//  Calculator
//
//  Created by MacBook Pro on 1/31/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorBrain.h"

@interface CalculatorBrain()

@property (nonatomic,strong) NSMutableArray *opperandStack;

@end


@implementation CalculatorBrain

@synthesize opperandStack = _opperandStack;



- (NSMutableArray*) opperandStack
{
    if (_opperandStack == nil)
    {
        _opperandStack = [[NSMutableArray alloc] init];
    }
    return _opperandStack;
}

- (void) pushOperand:(double) operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.opperandStack addObject:operandObject];
            
}

- (double) popOperand
{
    NSNumber *operandObject = [self.opperandStack lastObject];
    if (operandObject) [self.opperandStack removeLastObject];
    return [operandObject doubleValue];
}

-(void) clearStack
{
    [_opperandStack removeAllObjects];
}

- (double) performOperation:(NSString *) operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"])
    {
        result = [self popOperand] + [self popOperand];
    }
    else if ([@"*" isEqualToString:operation])
    {
        result = [self popOperand] * [self popOperand];
    }
    else if ([operation isEqualToString:@"-"])
    {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if ([operation isEqualToString:@"/"])
    {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    else if([operation isEqualToString:@"sin"])
    {
        double radians = [self popOperand] * (M_PI/180);
        result = sin(radians);
    }
    else if([operation isEqualToString:@"cos"])
    {
        double radians = [self popOperand] * (M_PI/180);
        result = cos(radians);
    }
    else if([operation isEqualToString:@"sqrt"])
    {
        result = sqrt([self popOperand]);
    }
    else if([operation isEqualToString:@"pi"])
    {
        result = M_PI;
    }
    
    [self pushOperand:result];
    
    return result;
}



@end