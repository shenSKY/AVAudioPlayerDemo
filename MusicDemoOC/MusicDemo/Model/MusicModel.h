//
//  MainPageModel.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/7.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject
//图片名字
@property (copy, nonatomic) NSString *icon;
//歌名
@property (copy, nonatomic) NSString *name;
//歌者
@property (copy, nonatomic) NSString *singer;
//音乐名
@property (copy, nonatomic) NSString *filename;
//歌词文件
@property (copy, nonatomic) NSString *lrcname;
//歌者图片
@property (copy, nonatomic) NSString *singerIcon;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
