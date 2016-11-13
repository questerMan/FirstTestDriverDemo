//
//  chatMainCell.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMainModel.h"


@interface ChatMainCell : UITableViewCell

//头像
@property (nonatomic, strong) UIImageView *headIMG;
//标题
@property (nonatomic, strong) UILabel *title;
//信息
@property (nonatomic, strong) UILabel *inform;

@property (nonatomic, strong) ChatMainModel *model;

@end
