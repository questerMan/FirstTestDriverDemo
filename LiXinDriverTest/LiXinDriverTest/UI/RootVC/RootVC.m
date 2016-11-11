//
//  RootVC.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()
@property (nonatomic, strong) PublicTool *tools;
@end

@implementation RootVC

-(PublicTool *)tools{
    if (!_tools) {
        _tools = [PublicTool shareInstance];
    }
    return _tools;
}
-(void)viewWillAppear:(BOOL)animated{
    
    
    //首次启动－－判断引导页
    if ([PublicTool isFirstOpenApp] != 1) {  //  首次启动
        
        //  设置引导图
        [self setGuidePage];
        
        [UserDefault setObject:[NSNumber numberWithInt:1] forKey:@"frist"];
        [UserDefault synchronize];
        
    }else{
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            //设置引导图广告页
            [self creatAdvert];
        });
    }
    
    //判断系统版本号
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self isNews];
    });
    
    [self creatNAC];
}

//判断系统版本号
-(void)isNews{
    NSLog(@"系统版本号 %d",[PublicTool getVersionNum]);
    NSString *currentMunber = [NSString stringWithFormat:@"%d",[PublicTool getVersionNum]];
    if (![currentMunber isEqualToString:version_Test]) {//版本不一样
        NSLog(@"系统版本号过低 当前版本%@  最新版本%d ",version_Test,[PublicTool getVersionNum]);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"主银，有新版本了哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}
#pragma mark - 设置引导图
-(void)setGuidePage{
    NSLog(@"首次启动，设置引导图");
    
    GuideView *guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    [guideView creatGuideViewWithIsGuide:YES];
}
#pragma mark - 设置引导图广告页
-(void)creatAdvert{
    GuideView *guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    [guideView creatAdvert];
}


/**
 *  创建导航栏
 */
-(void)creatNAC{
    
    //改变statusBar的前景色 1. View controller-based status bar appearance  为NO  2. Status bar style 为 Opaque black style
    
    //不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    //显示的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //创建左侧点击按钮
    [self setNavigationBarItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[self.tools scaleToSize:[UIImage imageNamed:@"xx"] size:CGSizeMake(MATCHSIZE(60), MATCHSIZE(60))] style:UIBarButtonItemStyleDone target:self action:@selector(rightOnclick:)];
    
}

-(void)rightOnclick:(UIBarButtonItem *)itemBtn{
    NSLog(@"右上角按钮");
      [self.navigationController pushViewController:[[MapViewController alloc] init] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
