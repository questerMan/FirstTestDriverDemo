//
//  DownLoadMapVC.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/9.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "DownLoadMapVC.h"

@interface DownLoadMapVC ()
@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation DownLoadMapVC

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backBtn;
}
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatNacOfTopBack];
    
}


-(void)creatNacOfTopBack{
    //返回按钮
    self.backBtn.frame = CGRectMake(MATCHSIZE(40), MATCHSIZE(40), MATCHSIZE(80), MATCHSIZE(80));
    [self.backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    self.backBtn.backgroundColor = DEFAULT_COLOR;
    [self.view addSubview:self.backBtn];
    
    //返回按钮点击事件
    [[self.backBtn
      rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        AlertView *alertView = [AlertView shareInstanceWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeGetDownLoad];
        [alertView alertViewClose];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
