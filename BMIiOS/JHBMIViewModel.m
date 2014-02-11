//
//  JHBMIViewModel.m
//  BMIiOS
//
//  Created by joehsieh on 2014/2/11.
//  Copyright (c) 2014年 JH. All rights reserved.
//

#import "JHBMIViewModel.h"
#import "UIColor+BMI.h"

CGFloat const kBMINormalWeightLowerBound = 18.5;
CGFloat const kBMINormalWeightUpperBound = 24.0;

CGFloat const kBMIOverWeightUpperBound = 27.0;
CGFloat const kBMIClassOneObesityUpperBound = 30.0;
CGFloat const kBMIClassTwoObesityUpperBound = 35.0;

NSString *const kMessageKey = @"message";
NSString *const kColorKey = @"color";

@implementation JHBMIViewModel

- (RACSignal *)BMIValueSignal
{
    return [RACSignal combineLatest:@[RACObserve(self, height), RACObserve(self, weight)] reduce:^id(id height, id weight){
        if (![self isValidNumberString:height] || ![self isValidNumberString:weight]) {
            return @"Invalid input";
        };
        CGFloat meterOfHeight = [height floatValue]/100.0;
        CGFloat kiloOfWeight = [weight floatValue];
        NSNumber *BMI = @(kiloOfWeight / (meterOfHeight * meterOfHeight));
        return [BMI stringValue];
    }];
}

- (RACSignal *)BMIStatusSignal
{
    return [[self BMIValueSignal] map:^id(id value) {
        if ([value isEqualToString:@"Invalid input"]) {
            return @{kMessageKey:@"Invalid input", kColorKey: [UIColor whiteColor]};
        }
        CGFloat BMI = [value floatValue];
        if (BMI < kBMINormalWeightLowerBound) {
            return @{kMessageKey:@"Under Weight", kColorKey: [UIColor grayColor]};
        }
        else if (BMI >= kBMINormalWeightLowerBound && BMI < kBMINormalWeightUpperBound) {
            return @{kMessageKey:@"Normal Weight", kColorKey: [UIColor greenColor]};
        }
        else if (BMI >= kBMINormalWeightUpperBound && BMI < kBMIOverWeightUpperBound) {
            return @{kMessageKey:@"Over Weight", kColorKey: [UIColor yellowColor]};
        }
        else if (BMI >= kBMIOverWeightUpperBound && BMI < kBMIClassOneObesityUpperBound) {
            return @{kMessageKey:@"Class I Weight", kColorKey: [UIColor lightCoral]};
        }
        else if (BMI >= kBMIClassOneObesityUpperBound && BMI < kBMIClassTwoObesityUpperBound) {
            return @{kMessageKey:@"Class II Weight", kColorKey: [UIColor indianRed]};
        }
        else if (BMI >= kBMIClassTwoObesityUpperBound) {
            return @{kMessageKey:@"Class III Weight", kColorKey: [UIColor redColor]};
        }
        return @{kMessageKey:@"Default", kColorKey: [UIColor whiteColor]};
    }];
}

- (BOOL)isValidNumberString:(NSString *)inString
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
