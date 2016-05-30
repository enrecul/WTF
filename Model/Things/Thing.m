//
//  Things.m
//  WTF
//
//  Created by 黄春涛 on 16/5/24.
//  Copyright © 2016年 黄春涛. All rights reserved.
//

#import "Thing.h"

@implementation Thing

@dynamic thingsTitle, thingsDetail, creater, users;

+ (NSString *)parseClassName {
    return @"Things";
}

@end
