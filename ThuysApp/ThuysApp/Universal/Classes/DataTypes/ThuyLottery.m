//
//  ThuyLottery.m
//  ThuysApp
//
//  Created by Thuy Hoang on 9/25/14.
//  Copyright (c) 2014 Thuy Hoang. All rights reserved.
//

#import "ThuyLottery.h"

@implementation ThuyLottery

static NSString *dateKey = @"date";
static NSString *lottoKey = @"lotto";
static NSString *jokerKey = @"joker";
static NSString *prizeKey = @"prize";
static NSString *linkKey = @"link";

- (NSString *)description {
    return [NSString stringWithFormat:@"{ date: %@, lotto: %@, joker: %@, prize: %@, link: %@ }",
            self.date,
            self.lotto,
            self.joker,
            self.prize,
            self.link];
}

+ (ThuyLottery *) lotteryFromDictionary: (NSDictionary *) dict {
    ThuyLottery *lottery = [[ThuyLottery alloc] init];
    
    lottery.date = [dict objectForKey:dateKey];
    lottery.lotto = [dict objectForKey:lottoKey];
    lottery.joker = [dict objectForKey:jokerKey];
    lottery.prize = [dict objectForKey:prizeKey];
    lottery.link = [dict objectForKey:linkKey];
    
    return lottery;
}

+ (NSArray *) lotteryFromArray:(NSArray *)lotteryArray {
    if (lotteryArray == nil) {
        return @[];
    }
    
    NSMutableArray *lotteries = [[NSMutableArray alloc] initWithCapacity:[lotteryArray count]];
    
    for (NSDictionary *lotteryDict in lotteryArray) {
        [lotteries addObject:[self lotteryFromDictionary:lotteryDict]];
    }
    
    return lotteries;
}


@end
