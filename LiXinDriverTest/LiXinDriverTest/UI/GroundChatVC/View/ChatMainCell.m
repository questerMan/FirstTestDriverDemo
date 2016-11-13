//
//  chatMainCell.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "chatMainCell.h"

@interface ChatMainCell()

@property (nonatomic,strong)PublicTool *tool;

@end

@implementation ChatMainCell

-(PublicTool *)tool{
    if (!_tool) {
        _tool = [PublicTool shareInstance];
    }
    return _tool;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.headIMG = [[UIImageView alloc] init];
    self.headIMG.frame = CGRectMake(MATCHSIZE_PX(10), MATCHSIZE_PX(10), MATCHSIZE_PX(100), MATCHSIZE_PX(100));
    [self addSubview:self.headIMG];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE_PX(120), MATCHSIZE_PX(10), SCREEN_W - MATCHSIZE_PX(130), MATCHSIZE_PX(50))];
    self.title.textColor = [UIColor blueColor];
    self.title.font = [UIFont systemFontOfSize:MATCHSIZE_PX(25)];
    self.title.numberOfLines = 1;
    self.title.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.title];
    
    self.inform = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE_PX(120), MATCHSIZE_PX(60), SCREEN_W - MATCHSIZE_PX(130), MATCHSIZE_PX(50))];
    self.inform.textColor = [UIColor grayColor];
    self.inform.font = [UIFont systemFontOfSize:MATCHSIZE_PX(25)];
    self.inform.numberOfLines = 1;
    self.inform.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.inform];
}



-(void)setModel:(ChatMainModel *)model{
    _model = model;
    
    [self.headIMG sd_setImageWithURL:[NSURL URLWithString:model.headIMG] placeholderImage:[self.tool scaleToSize:[UIImage imageNamed:@"chat_headIMG"] size:CGSizeMake(MATCHSIZE_PX(100), MATCHSIZE_PX(100))]];
    
    self.title.text = model.title;
    
    self.inform.text = model.inform;
}

@end
