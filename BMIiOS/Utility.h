//
//  Utility.h
//  BMIiOS
//
//  Created by joehsieh on 2015/8/28.
//  Copyright (c) 2015年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat const kBMINormalWeightLowerBound = 18.5;
static CGFloat const kBMINormalWeightUpperBound = 24.0;

static CGFloat const kBMIOverWeightUpperBound = 27.0;
static CGFloat const kBMIClassOneObesityUpperBound = 30.0;
static CGFloat const kBMIClassTwoObesityUpperBound = 35.0;

static NSString *const kMessageKey = @"message";
static NSString *const kColorKey = @"color";

@interface Utility : NSObject
+ (BOOL)isValidNumberString:(NSString *)inString;
@end
