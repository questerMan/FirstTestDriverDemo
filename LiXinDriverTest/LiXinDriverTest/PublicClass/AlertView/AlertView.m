//
//  AlertView.m
//  AlertViewDemo
//
//  Created by lixin on 16/10/20.
//  Copyright © 2016年 lixin. All rights reserved.
//

#import "AlertView.h"

@interface AlertView()
//{
//    AlertViewController *_alertViewController;
//    PayVC *_payVC;
//}

@property (nonatomic,strong) LoginVC *loginVC;

@property (nonatomic,strong) DownLoadMapVC *downLoadMap;
@property (nonatomic,strong) MapViewController *mapVC;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *alertView;


@end

@implementation AlertView
/** 登录--懒加载 */
-(LoginVC *)loginVC{
    if (!_loginVC) {
        _loginVC = [[LoginVC alloc] init];
        
        _loginVC.view.frame = CGRectMake(0, 0, SELF_W, SELF_H);
    }
    return _loginVC;
}
-(MapViewController *)mapVC{
    if (!_mapVC) {
        _mapVC = [[MapViewController alloc] init];
        
        _mapVC.view.frame = CGRectMake(0, 0, SELF_W, SELF_H);
    }
    return _mapVC;
}



-(DownLoadMapVC *)downLoadMap{
    if (!_downLoadMap) {
        _downLoadMap = [[DownLoadMapVC alloc] init];
        _downLoadMap.view.frame = CGRectMake(0, 0, SELF_W, SELF_H);
        
    }
    return _downLoadMap;
}

/** 单例 */
+ (AlertView *)shareInstanceWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType{
    

    static dispatch_once_t onceToken;
    static AlertView * shareAlert = nil;
    dispatch_once(&onceToken, ^{
        shareAlert = [[AlertView alloc]initWithFrame:frame AndAddAlertViewType:alertViewType];
    });
    
    shareAlert.addAlertViewType = alertViewType;

    return shareAlert;
}


//直接调用该方法一般用于固定 view 的展示
-(instancetype)initWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType{
    
    _addAlertViewType = alertViewType;
    
    if (self = [super initWithFrame:frame]) {
        
        if (alertViewType == AlertViewTypeGetLogin) {

            
        }
        else if (alertViewType == AlertViewTypeGetDownLoad) {

            
        }
        else if (alertViewType == AlertViewTypeGetMap) {
            
            
        }
        //        if (AlertViewTypeGetPay == alertViewType) {
        //
        //        }else{
        //
        //            self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        //
        //            self.bgView.backgroundColor = [UIColor blackColor];
        //            self.bgView.alpha = 0.3;
        //
        //            [self addSubview:self.bgView];
        //
        //            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        //        }
    }
    return self;
}

-(void)animatedAlertViewTypeOne{
    
    self.alertView = [[UIView alloc] initWithFrame:CGRectMake(SELF_W, 0, SELF_W, SELF_H)];
    self.alertView.alpha = 0;
    self.alertView.userInteractionEnabled = YES;
    [self addSubview:self.alertView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.alpha = 1;
        self.alertView.frame = CGRectMake(0, 0, SELF_W, SELF_H);
    }];

}

-(void)alertViewShow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    
    //登录LoginVC
    if (_addAlertViewType == AlertViewTypeGetLogin) {
        
        [self animatedAlertViewTypeOne];
        
        [self.alertView addSubview:self.loginVC.view];
        

        [window addSubview:self];
        
    }
    
    else if (_addAlertViewType == AlertViewTypeGetDownLoad) {

        [self animatedAlertViewTypeOne];

        [self.alertView addSubview:self.downLoadMap.view];
        
        [window addSubview:self];

    }
    else if (_addAlertViewType == AlertViewTypeGetMap) {
        
        [self animatedAlertViewTypeOne];
        
        [self.alertView addSubview:self.mapVC.view];
        
        [window addSubview:self];
        
    }
    
    //    if (_addAlertViewType == AlertViewTypeGetPay) {
    //        if (self.alertView) return;
    //
    //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //
    //        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(40, SCREEN_H/2-SCREEN_H / 4/2, SCREEN_W-80, SCREEN_H / 4)];
    //        self.alertView.alpha = 0;
    //        self.alertView.userInteractionEnabled = YES;
    //
    //        [self.alertView addSubview:[self addPayVC].view];
    //        [self addSubview:self.alertView];
    //
    //
    //        [UIView animateWithDuration:0.5 animations:^{
    //            self.alertView.alpha = 1;
    //        }];
    //
    //        [window addSubview:self];
    //    }else{
    //
    //        if (self.alertView) return;
    //
    //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //
    //        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H / 2)];
    //
    //        self.alertView.userInteractionEnabled = YES;
    //
    //        [self.alertView addSubview:[self addAlertViewController].view];
    //        [self addSubview:self.alertView];
    //
    //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //        self.bgView.userInteractionEnabled = YES;
    //        [self.bgView addGestureRecognizer:tap];
    //
    //        [UIView animateWithDuration:0.5 animations:^{
    //            self.alertView.y = SCREEN_H /2;
    //        }];
    //
    //        [window addSubview:self];
    //
    //    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    [self alertViewClose];
    
}
//-(PayVC *)addPayVC{
//    if (!_payVC) {
//
//        _payVC = [[PayVC alloc] init];
//        _payVC.view.frame = CGRectMake(0, 0, self.alertView.width,self.alertView.height);
//        _payVC.delegate = self;
//        [self.alertView addSubview:_payVC.view];
//
//    }
//    return _payVC;
//}
//-(void)alertPayVC:(PayVC *)payVC AndBtnClick:(UIButton *)btn{
//    if (btn.tag == 100) {
//        [self alertViewClose];
//    }else{
//        btn.selected = !btn.selected;
//        if (btn.selected) {
//            [UIView animateWithDuration:0.4 animations:^{
//                //eself.addBtn.hidden = NO;
//                self.alertView.frame = CGRectMake(40, SCREEN_H/2-SCREEN_H / 4/2, SCREEN_W-80, SCREEN_H / 4+80);
//
//                payVC.btn1.frame = CGRectMake(0, self.frame.size.height/4-40+80, (self.frame.size.width-80)/2-1,40 );
//                payVC.btn2.frame = CGRectMake((self.frame.size.width-80)/2+2, self.frame.size.height/4-40+80, (self.frame.size.width-80)/2-1,40 );
//
//            }completion:^(BOOL finished) {
//                [btn setTitle:@"上拉" forState:UIControlStateNormal];
//            }];
//        }else{
//            [UIView animateWithDuration:0.4 animations:^{
//                //eself.addBtn.hidden = NO;
//                self.alertView.frame = CGRectMake(40, SCREEN_H/2-SCREEN_H / 4/2, SCREEN_W-80, SCREEN_H / 4);
//                payVC.btn1.frame = CGRectMake(0, self.frame.size.height/4-40, (self.frame.size.width-80)/2-1,40 );
//                payVC.btn2.frame = CGRectMake((self.frame.size.width-80)/2+2, self.frame.size.height/4-40, (self.frame.size.width-80)/2-1,40 );
//            }completion:^(BOOL finished) {
//                [btn setTitle:@"下拉" forState:UIControlStateNormal];
//
//            }];
//        }
//    }
//}
//-(AlertViewController *)addAlertViewController{
//    if (!_alertViewController) {
//
//        _alertViewController = [[AlertViewController alloc] init];
//        _alertViewController.view.frame = CGRectMake(0, 0, SCREEN_W,self.alertView.height);
//
//        [self.alertView addSubview:_alertViewController.view];
//
//    }
//    return _alertViewController;
//
//}

-(void)alertViewClose{
    [UIView animateWithDuration:0.5 animations:^{
        if (_addAlertViewType == AlertViewTypeGetLogin || _addAlertViewType == AlertViewTypeGetDownLoad) {
            self.alertView.alpha = 0;
            self.alertView.frame = CGRectMake(SELF_W, 0, SELF_W, SELF_H);
        }
       
        //      if (_addAlertViewType == AlertViewTypeGetPay) {
        //
        //        }else{
        //            self.alertView.y = SCREEN_H;
        //        }
        //        self.alertView.alpha = 0;
    } completion:^(BOOL finished) {
        
                [self.alertView removeFromSuperview];
                 self.alertView = nil;
                [self removeFromSuperview];
        
        if (_addAlertViewType == AlertViewTypeGetLogin) {
            [self.loginVC.view removeFromSuperview];
        }
        else if(_addAlertViewType == AlertViewTypeGetDownLoad){
            [self.downLoadMap.view removeFromSuperview];
        }
        else if(_addAlertViewType == AlertViewTypeGetMap){
            [self.mapVC.view removeFromSuperview];
        }
    }];
}



-(void)keyboardWillChange:(NSNotification  *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    CGFloat duration = [dict[UIKeyboardAnimationCurveUserInfoKey] doubleValue];
    
    CGFloat selfY = keyboardY - SCREEN_H;
    
    [UIView animateWithDuration:duration animations:^{
        self.y = selfY;
    } completion:^(BOOL finished) {
       
    }];
    
}

@end
