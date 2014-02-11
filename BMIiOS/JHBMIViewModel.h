//
//  JHBMIViewModel.h
//  BMIiOS
//
//  Created by joehsieh on 2014/2/11.
//  Copyright (c) 2014年 JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface JHBMIViewModel : NSObject
@property(nonatomic, strong) NSString *height;
@property(nonatomic, strong) NSString *weight;
- (RACSignal *)BMIValueSignal;
- (RACSignal *)BMIStatusSignal;
@end
