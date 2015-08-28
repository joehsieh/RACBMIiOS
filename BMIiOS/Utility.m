//
//  Utility.m
//  BMIiOS
//
//  Created by joehsieh on 2015/8/28.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (BOOL)isValidNumberString:(NSString *)inString
{
    if ([inString length] == 0) return NO;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setAllowsFloats:YES];
    [formatter setDecimalSeparator:@"."];
    
    NSNumber *number = [formatter numberFromString: inString];
    
    if(number == nil) return NO;
    if ([number isEqualToNumber:@(0)]) return NO;
    return YES;
}

@end
