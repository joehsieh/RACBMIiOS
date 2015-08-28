//
//  JHBMIViewModel.m
//  BMIiOS
//
//  Created by joehsieh on 2014/2/11.
//  Copyright (c) 2014年 JH. All rights reserved.
//

#import "JHBMIViewModel.h"
#import "UIColor+BMI.h"
#import "Utility.h"

@implementation JHBMIViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.BMIModel = [[JHBMIModel alloc] init];
    }
    return self;
}
- (RACSignal *)BMIValueSignal
{
    return [RACSignal combineLatest:@[RACObserve(self.BMIModel, heightString), RACObserve(self.BMIModel, weightString)] reduce:^id(id height, id weight){
        if (![Utility isValidNumberString:height] || ![Utility isValidNumberString:weight]) {
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

@end
