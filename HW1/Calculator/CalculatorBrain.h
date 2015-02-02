//
//  CalculatorBrain.h
//  Calculator
//
//  Created by MacBook Pro on 1/31/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

#ifndef Calculator_CalculatorBrain_h
#define Calculator_CalculatorBrain_h

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double) operand;
- (double) performOperation:(NSString*) operation;

@end

#endif
