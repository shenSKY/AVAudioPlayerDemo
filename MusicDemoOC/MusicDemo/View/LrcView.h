//
//  LrcView.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LrcLabel.h"

@interface LrcView : UIScrollView
//歌词名称
@property (copy, nonatomic) NSString *lrcName;
//当前歌曲播放时间
@property (assign, nonatomic) NSTimeInterval currentTime;
//外面的歌词
@property (weak, nonatomic) LrcLabel *lrcLabel;

@end
