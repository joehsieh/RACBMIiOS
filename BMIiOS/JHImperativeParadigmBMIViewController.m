//
//  JHImperativeParadigmBMIViewController.m
//  BMIiOS
//
//  Created by joehsieh on 2015/8/28.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import "JHImperativeParadigmBMIViewController.h"
#import "Utility.H"
#import "UIColor+BMI.h"

@interface JHImperativeParadigmBMIViewController ()

@end

@implementation JHImperativeParadigmBMIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)inTextField
{
    NSString *heightString = self.heightTextField.text;
    NSString *weightString = self.weightTextField.text;
    if (![Utility isValidNumberString:heightString] || ![Utility isValidNumberString:weightString]) {
        self.BMIValueLabel.text = @"Invalid input";
        [self jh_updateBMIStatusWithBMIValue:self.BMIValueLabel.text];
        return;
    };
    CGFloat meterOfHeight = [heightString floatValue]/100.0;
    CGFloat kiloOfWeight = [weightString floatValue];
    NSNumber *BMI = @(kiloOfWeight / (meterOfHeight * meterOfHeight));
    self.BMIValueLabel.text = [BMI stringValue];
    [self jh_updateBMIStatusWithBMIValue:self.BMIValueLabel.text];
    [self jh_updateBackgroundColorWithBMIValue:self.BMIValueLabel.text];
}

- (void)jh_updateBMIStatusWithBMIValue:(NSString *)inString
{
    if ([inString isEqualToString:@"Invalid input"]) {
        self.BMIStatusLabel.text = inString;
        return;
    }
    CGFloat BMI = [inString floatValue];
    self.BMIStatusLabel.text = [self jh_BMIDictionaryWith:BMI][kMessageKey];
}

- (void)jh_updateBackgroundColorWithBMIValue:(NSString *)inString
{
    if ([inString isEqualToString:@"Invalid input"]) {
        self.BMIStatusLabel.text = inString;
        return;
    }
    CGFloat BMI = [inString floatValue];
    self.view.backgroundColor = [self jh_BMIDictionaryWith:BMI][kColorKey];
}

- (NSDictionary *)jh_BMIDictionaryWith:(CGFloat)inBMIValue
{
    NSString *result = @"";
    UIColor *color = [UIColor whiteColor];
    if (inBMIValue < kBMINormalWeightLowerBound) {
        result = @"Under Weight";
        color = [UIColor grayColor];
    }
    else if (inBMIValue >= kBMINormalWeightLowerBound && inBMIValue < kBMINormalWeightUpperBound) {
        result = @"Normal Weight";
        color = [UIColor greenColor];
    }
    else if (inBMIValue >= kBMINormalWeightUpperBound && inBMIValue < kBMIOverWeightUpperBound) {
        result = @"Over Weight";
        color = [UIColor yellowColor];
    }
    else if (inBMIValue >= kBMIOverWeightUpperBound && inBMIValue < kBMIClassOneObesityUpperBound) {
        result = @"Class I Weight";
        color = [UIColor lightCoral];
    }
    else if (inBMIValue >= kBMIClassOneObesityUpperBound && inBMIValue < kBMIClassTwoObesityUpperBound) {
        result = @"Class II Weight";
        color = [UIColor indianRed];
    }
    else if (inBMIValue >= kBMIClassTwoObesityUpperBound) {
        result = @"Class III Weight";
        color = [UIColor redColor];
    }
    return @{kMessageKey:result, kColorKey: color};
}
@end
