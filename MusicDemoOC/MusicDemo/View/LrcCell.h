//
//  LrcCell.h
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/9.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LrcLabel;

@interface LrcCell : UITableViewCell
//歌词
@property (weak, nonatomic) IBOutlet LrcLabel *lrcLabel;
@end
