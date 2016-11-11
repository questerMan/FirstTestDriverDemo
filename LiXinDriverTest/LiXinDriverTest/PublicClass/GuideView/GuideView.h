//
//  GuideView.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideView : UIView



@property (nonatomic, assign) BOOL isGuide;//默认是引导页 Yes

@property (nonatomic, strong)NSMutableArray *arrayIMG;

-(void)creatGuideViewWithIsGuide:(BOOL)isGuide;
-(void)creatAdvert;
@end
