//
//  UIViewController+Navigation.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/11.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(void)changeNavigation{
    
    self.navigationController.navigationBarHidden = NO;
    
    //不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //显示的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}



@end
