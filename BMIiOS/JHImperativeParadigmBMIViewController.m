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
}

- (void)jh_updateBMIStatusWithBMIValue:(NSString *)inString
{
    if ([inString isEqualToString:@"Invalid input"]) {
        self.BMIStatusLabel.text = inString;
        return;
    }
    CGFloat BMI = [inString floatValue];
    NSString *result = @"";
    UIColor *color = [UIColor whiteColor];
    if (BMI < kBMINormalWeightLowerBound) {
        result = @"Under Weight";
        color = [UIColor grayColor];
    }
    else if (BMI >= kBMINormalWeightLowerBound && BMI < kBMINormalWeightUpperBound) {
        result = @"Normal Weight";
        color = [UIColor greenColor];
    }
    else if (BMI >= kBMINormalWeightUpperBound && BMI < kBMIOverWeightUpperBound) {
        result = @"Over Weight";
        color = [UIColor yellowColor];
    }
    else if (BMI >= kBMIOverWeightUpperBound && BMI < kBMIClassOneObesityUpperBound) {
        result = @"Class I Weight";
        color = [UIColor lightCoral];
    }
    else if (BMI >= kBMIClassOneObesityUpperBound && BMI < kBMIClassTwoObesityUpperBound) {
        result = @"Class II Weight";
        color = [UIColor indianRed];
    }
    else if (BMI >= kBMIClassTwoObesityUpperBound) {
        result = @"Class III Weight";
        color = [UIColor redColor];
    }
    self.BMIStatusLabel.text = @"Under Weight";
    self.view.backgroundColor = color;
}

@end
