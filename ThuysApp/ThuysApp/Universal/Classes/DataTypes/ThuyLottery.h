//
//  ThuyLottery.h
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThuyLottery : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *lotto;
@property (nonatomic, strong) NSString *joker;
@property (nonatomic, strong) NSString *prize;
@property (nonatomic, strong) NSString *link;

+ (ThuyLottery *) lotteryFromDictionary: (NSDictionary *) dict;
+ (NSArray *) lotteryFromArray:(NSArray *)array;

@end
