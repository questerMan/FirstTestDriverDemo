//
//  LeftHeaderUserCell.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LeftHeaderUserCellBlock)(UIButton *btn);

@interface LeftHeaderUserCell : UITableViewCell

@property (nonatomic, copy) LeftHeaderUserCellBlock myBlock;
//头像
@property (nonatomic, strong) UIButton *userIMG;

//级别
@property (nonatomic, strong) UIImageView *starIMG;

//昵称
@property (nonatomic, strong) UILabel *userName;

//电话
@property (nonatomic, strong) UILabel *number;

-(void)onClickWithBlcok:(LeftHeaderUserCellBlock)myBlock;

@end
