//
//  LeftHeaderUserCell.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LeftHeaderUserCell.h"

@implementation LeftHeaderUserCell




- (instancetype)init
{
    self = [super init];
    if (self) {
        [self creatUI];
    }
    return self;
}


-(void)creatUI{
    
    self.backgroundColor = DEFAULT_COLOR;

    PublicTool *tool = [PublicTool shareInstance];
    //头像
    self.userIMG = [UIButton buttonWithType:UIButtonTypeCustom];
    self.userIMG.frame = CGRectMake(MATCHSIZE(225), MATCHSIZE(25), MATCHSIZE(100), MATCHSIZE(100));
    [self.userIMG setBackgroundImage:[tool scaleToSize:[UIImage imageNamed:@"user"] size:CGSizeMake(MATCHSIZE(100), MATCHSIZE(100))] forState:UIControlStateNormal];
    [self.userIMG addTarget:self action:@selector(userOnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.userIMG.layer.cornerRadius = MATCHSIZE(50);
    self.userIMG.layer.masksToBounds = YES;
    [self addSubview:self.userIMG];
    //级别
    self.starIMG = [[UIImageView alloc] initWithFrame:CGRectMake(MATCHSIZE(35), MATCHSIZE(75), MATCHSIZE(30), MATCHSIZE(30))];
    self.starIMG.image = [tool scaleToSize:[UIImage imageNamed:@"star"] size:CGSizeMake(MATCHSIZE(30), MATCHSIZE(30))]  ;
    [self.userIMG addSubview:self.starIMG];
    //昵称
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(200), MATCHSIZE(150), MATCHSIZE(150), MATCHSIZE(40))];
    [self.userName setTextColor:RGBAlpha(255, 255, 255, 1)];
    [self.userName setText:@"赵＊铭"];
    self.userName.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.numberOfLines = 1;
    [self addSubview:self.userName];
    //电话
    self.number = [[UILabel alloc] initWithFrame:CGRectMake(MATCHSIZE(180), MATCHSIZE(215), MATCHSIZE(190), MATCHSIZE(40))];
    [self.number setTextColor:RGBAlpha(255, 255, 255, 1)];
    [self.number setText:@"188****6403"];
    self.number.font = [UIFont systemFontOfSize:MATCHSIZE(30)];
    self.number.textAlignment = NSTextAlignmentCenter;
    self.number.numberOfLines = 1;
    [self addSubview:self.number];
    
}

-(void)userOnclick:(UIButton *)btn{

    _myBlock(btn);
    
    //判断有没有登录


    //进入登录页面
    AlertView *alertView = [AlertView shareInstanceWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeGetLogin];
    [alertView alertViewShow];
    
}
// 点击   block  （登录时关闭左侧栏）
-(void)onClickWithBlcok:(LeftHeaderUserCellBlock)myBlock{
    _myBlock = myBlock;
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
