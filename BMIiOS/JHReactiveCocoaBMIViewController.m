//
//  JHViewController.m
//  BMIiOS
//
//  Created by joehsieh on 2014/2/9.
//  Copyright (c) 2014年 JH. All rights reserved.
//

#import "JHReactiveCocoaBMIViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIColor+BMI.h"
#import "Utility.h"

NSString *const kMessageKey = @"message";
NSString *const kColorKey = @"color";

@implementation JHReactiveCocoaBMIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.BMIModel = [[JHBMIModel alloc] init];
    RAC(self.BMIModel, height) = self.heightTextField.rac_textSignal;
    RAC(self.BMIModel, weight) = self.weightTextField.rac_textSignal;
    
    RACSignal *BMISignal = [RACSignal combineLatest:@[self.heightTextField.rac_textSignal, self.weightTextField.rac_textSignal] reduce:^id(id height, id weight){
        if (![Utility isValidNumberString:height] || ![Utility isValidNumberString:weight]) {
            return @"Invalid input";
        };
        CGFloat meterOfHeight = [height floatValue]/100.0;
        CGFloat kiloOfWeight = [weight floatValue];
        NSNumber *BMI = @(kiloOfWeight / (meterOfHeight * meterOfHeight));
        return [BMI stringValue];
    }];
    
    RAC(self.BMIValueLabel, text) = BMISignal;
    
    RACSignal *BMIDataSignal = [BMISignal map:^id(id value) {
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
    
    RAC(self.view, backgroundColor) = [BMIDataSignal map:^id(id value) {
        return value[kColorKey];
    }];
    
    RAC(self.BMIStatusLabel, text) = [BMIDataSignal map:^id(id value) {
        return value[kMessageKey];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
