//
//  MainVC.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()


@property (nonatomic,strong) PublicTool *tool;

@end

@implementation MainVC

-(PublicTool *)tool{
    if (!_tool) {
        _tool = [PublicTool shareInstance];
    }
    return _tool;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  
}



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"－－－－－－－－－%f",MATCHSIZE(SCREEN_W));
    //头部滚动展示视图
    [self creatScrollView];
  
}

#pragma mark - 头部滚动展示视图
-(void)creatScrollView{
    AlertView * alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, MATCHSIZE(300)) AndAddAlertViewType:AlertViewTypeGetHeaderScroll];
    [alertView alertViewShow];
    [self.view addSubview:alertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark SlideMenuControllerDelegate 侧滑代理方法
//左栏将要打开
-(void)leftWillOpen{
    
}
//左栏已经打开
-(void)leftDidOpen{
    
    [self addLeftGestures];//添加滑动手势
    
}
//左边将要关闭
-(void)leftWillClose{
    
}
//左边已经关闭
-(void)leftDidClose{
    [self removeLeftGestures];//移除滑动手势
    [self addLeftGestures];//添加左边滑动式图
}

@end
