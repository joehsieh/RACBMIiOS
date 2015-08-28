//
//  JHImperativeParadigmBMIViewController.h
//  BMIiOS
//
//  Created by joehsieh on 2015/8/28.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHImperativeParadigmBMIViewController : UIViewController
@property (assign, nonatomic) IBOutlet UITextField *heightTextField;
@property (assign, nonatomic) IBOutlet UITextField *weightTextField;
@property (assign, nonatomic) IBOutlet UILabel *BMIValueLabel;
@property (assign, nonatomic) IBOutlet UILabel *BMIStatusLabel;
- (IBAction)textFieldDidChange:(UITextField *)inTextField;
@end
