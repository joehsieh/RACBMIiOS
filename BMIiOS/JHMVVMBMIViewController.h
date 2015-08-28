//
//  JHViewController.h
//  BMIiOS
//
//  Created by joehsieh on 2014/2/9.
//  Copyright (c) 2014年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHBMIViewModel.h"

@interface JHMVVMBMIViewController : UIViewController
@property (assign, nonatomic) IBOutlet UITextField *heightTextField;
@property (assign, nonatomic) IBOutlet UITextField *weightTextField;
@property (assign, nonatomic) IBOutlet UILabel *BMIValueLabel;
@property (assign, nonatomic) IBOutlet UILabel *BMIStatusLabel;

@property (nonatomic, strong) JHBMIViewModel *BMIViewModel;
@end
