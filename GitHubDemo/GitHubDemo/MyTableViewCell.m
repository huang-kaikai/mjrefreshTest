//
//  MyTableViewCell.m
//  GitHubDemo
//
//  Created by ryan.huang on 2020/3/26.
//  Copyright © 2020 ryan.huang. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.icon1 = [[UIButton alloc] init];
        [self.contentView addSubview:_icon1];

        self.label1 = [[UILabel alloc] init];
        [self.contentView addSubview:_label1];

        self.label2 = [[UILabel alloc] init];
        [self.contentView addSubview:_label2];
        
        self.image = [[UIView alloc] init];
        [self.contentView addSubview:_image];

        //一共定义了一个Button，两个Label
    }
    return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];

     //设置每一个的位置
    _icon1.frame = CGRectMake(300, 0, 55, 50);

    _label1.frame = CGRectMake(10, 0, 100, 50);

    _label2.frame = CGRectMake(100, 0, 200, 50);
    
    _image.frame = CGRectMake(65, 0, 55, 50);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
