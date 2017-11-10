//
//  MainPageCell.m
//  MusicDemo
//
//  Created by 沈凯 on 2017/11/7.
//  Copyright © 2017年 Ssky. All rights reserved.
//

#import "MainPageCell.h"

@interface MainPageCell ()
//图片
@property (weak, nonatomic) IBOutlet UIImageView *img;
//歌名
@property (weak, nonatomic) IBOutlet UILabel *songName;
//作者名
@property (weak, nonatomic) IBOutlet UILabel *singer;

@end

@implementation MainPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(MusicModel *)model
{
    _model = model;
    [self.img setImage:[UIImage imageNamed:model.singerIcon]];
    self.songName.text = model.name;
    self.singer.text = model.singer;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
