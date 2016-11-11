//
//  UIViewController+SlideMenuControllerOC.m
//  SlideMenuControllerOC
//
//  Created by ChipSea on 16/2/29.
//  Copyright © 2016年 pluto-y. All rights reserved.
//

#import "UIViewController+SlideMenuControllerOC.h"


@implementation UIViewController (SlideMenuControllerOC)

-(void)setNavigationBarItem {
    PublicTool *tool = [PublicTool shareInstance];
    [self addLeftBarButtonWithImage:[tool scaleToSize:[UIImage imageNamed:@"ic_menu_black_24dp"] size:CGSizeMake(MATCHSIZE(60), MATCHSIZE(60))]];

    //[self.slideMenuController removeLeftGestures];
    [self.slideMenuController removeRightGestures];
//    [self.slideMenuController addLeftGestures];
//    [self.slideMenuController addRightGestures];
    
}

-(void)removeNavigationBarItem {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    [self.slideMenuController removeLeftGestures];
    [self.slideMenuController removeRightGestures];
}

-(void)prensentCloseLeftViewWithViewController:(UIViewController *)newsViewController
                                   andAnimated:(BOOL)animated
{
    [self closeLeft];
    [self presentViewController:newsViewController animated:animated completion:nil];
}

-(void)closeLeftView{
    [self closeLeft];

}
-(void)addLeftGestures{
    
    [self.slideMenuController addLeftGestures];

}
-(void)removeLeftGestures{
    
    [self.slideMenuController removeLeftGestures];

}
@end
