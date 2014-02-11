//
//  JHViewController.m
//  BMIiOS
//
//  Created by joehsieh on 2014/2/9.
//  Copyright (c) 2014年 JH. All rights reserved.
//

#import "JHViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface JHViewController ()

@end

@implementation JHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.BMIViewModel = [[JHBMIViewModel alloc] init];
    RAC(self.BMIViewModel.BMIModel, height) = self.heightTextField.rac_textSignal;
    RAC(self.BMIViewModel.BMIModel, weight) = self.weightTextField.rac_textSignal;
    RAC(self.BMIValueLabel, text) = [self.BMIViewModel BMIValueSignal];
    RAC(self.view, backgroundColor) = [[self.BMIViewModel BMIStatusSignal] map:^id(id value) {
        return value[kColorKey];
    }];
    RAC(self.BMIStatusLabel, text) = [[self.BMIViewModel BMIStatusSignal] map:^id(id value) {
        return value[kMessageKey];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
