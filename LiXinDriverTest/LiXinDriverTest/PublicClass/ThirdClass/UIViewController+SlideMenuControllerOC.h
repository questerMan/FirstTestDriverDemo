//
//  UIViewController+SlideMenuControllerOC.h
//  SlideMenuControllerOC
//
//  Created by ChipSea on 16/2/29.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SlideMenuControllerOC)

//设置导航栏item
-(void)setNavigationBarItem;

//移除导航栏Item
-(void)removeNavigationBarItem;

//关闭侧栏跳转
-(void)prensentCloseLeftViewWithViewController:(UIViewController *)newsViewController
                                     andAnimated:(BOOL)animated;

-(void)closeLeftView;
-(void)addLeftGestures;
-(void)removeLeftGestures;
@end
