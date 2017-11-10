//
//  LrcTool.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LrcTool : NSObject
+ (NSArray *)getLrcsWithLrcName:(NSString *)lrcName;
@end
