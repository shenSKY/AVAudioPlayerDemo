//
//  MainPageModel.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/7.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
