//
//  LoginVC.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/8.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *backBtn;

@property (nonatomic,strong) UIImageView *logoIMG;

@property (nonatomic,strong) UITextField *userF;
@property (nonatomic,strong) UITextField *pwdF;
@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic, strong) PublicTool *tool;
@end

@implementation LoginVC

-(UIImageView *)logoIMG{
    if (!_logoIMG) {
        _logoIMG = [[UIImageView alloc] init];
    }
    return _logoIMG;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backBtn;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _loginBtn;
}

-(void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//黑色

}
-(void)viewWillDisappear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//白色

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    
}
-(void)creatUI{
    
    _tool = [PublicTool shareInstance];
   
    
    //logo图
    self.logoIMG.frame = CGRectMake(MATCHSIZE(40), MATCHSIZE(130), SCREEN_W-MATCHSIZE(80), MATCHSIZE(310));
    self.logoIMG.image = [self.tool scaleToSize:[UIImage imageNamed:@"logo.jpg"] size:CGSizeMake(SCREEN_W-MATCHSIZE(80), MATCHSIZE(310))];
    [self.view addSubview:self.logoIMG];
    
    //返回按钮
    self.backBtn.frame = CGRectMake(MATCHSIZE(40), MATCHSIZE(40), MATCHSIZE(80), MATCHSIZE(80));
    [self.backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    self.backBtn.backgroundColor = DEFAULT_COLOR;
    [self.view addSubview:self.backBtn];
    
    
    [self.userF becomeFirstResponder];
    
    self.userF = [[UITextField alloc] init];
    self.userF.frame = CGRectMake(MATCHSIZE(40), MATCHSIZE(450), SCREEN_W-MATCHSIZE(80), MATCHSIZE(80));
    self.userF.backgroundColor = [UIColor clearColor];
    self.userF.placeholder = @"userName";
    [self.userF setTextColor:DEFAULT_COLOR];
    self.userF.layer.borderWidth = MATCHSIZE(2);
    self.userF.layer.borderColor = DEFAULT_COLOR.CGColor;
    self.userF.leftView = [[UIImageView alloc] initWithImage:[_tool scaleToSize:[UIImage imageNamed:@"userIMG"] size:CGSizeMake(MATCHSIZE(65), MATCHSIZE(65))]];
    self.userF.leftViewMode = UITextFieldViewModeAlways;
    self.userF.tag = 100001;
    self.userF.delegate = self;
    [self.view addSubview:self.userF];
    
    self.pwdF = [[UITextField alloc] init];
    self.pwdF.frame = CGRectMake(MATCHSIZE(40), MATCHSIZE(550), SCREEN_W-MATCHSIZE(80), MATCHSIZE(80));
    self.pwdF.tag = 100002;
    self.pwdF.delegate = self;
    self.pwdF.placeholder = @"password";
    self.pwdF.secureTextEntry = YES;
    self.pwdF.enabled = NO;
    self.pwdF.backgroundColor = [UIColor clearColor];
    [self.pwdF setTextColor:DEFAULT_COLOR];
    self.pwdF.layer.borderWidth = MATCHSIZE(2);
    self.pwdF.layer.borderColor = DEFAULT_COLOR.CGColor;
    self.pwdF.leftView = [[UIImageView alloc] initWithImage:[_tool scaleToSize:[UIImage imageNamed:@"pwdIMG"] size:CGSizeMake(MATCHSIZE(65), MATCHSIZE(65))]];
    self.pwdF.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.pwdF];
    
    self.loginBtn.frame = CGRectMake(MATCHSIZE(40), MATCHSIZE(700), SCREEN_W-MATCHSIZE(80), MATCHSIZE(80));
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.enabled = NO;
//    self.loginBtn.layer.borderWidth = MATCHSIZE(2);
//    self.loginBtn.layer.borderColor = DEFAULT_COLOR.CGColor;
    [self.loginBtn setTitleColor:RGBAlpha(255, 255, 255, 1) forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:RGBAlpha(99, 184, 255, 1) forState:UIControlStateHighlighted];
    self.loginBtn.backgroundColor = DEFAULT_COLOR;
    [self.view addSubview:self.loginBtn];
    
    
    [self loginBtnOnclick];
    
    //textFile输入键盘设置
    self.userF.keyboardType = UIKeyboardTypeNumberPad;
    self.pwdF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
}
/** 逻辑判断 */
-(void)loginBtnOnclick{
    
    @weakify(self);
    /**
     
     [[self.userF.rac_textSignal filter:^BOOL(id value) {
     NSString *text = value;
     BOOL isMobMumber = [_tool isMobileNumber:text];
     return text.length < 11 || isMobMumber == NO;
     }] subscribeNext:^(id x) {
     @strongify(self)
     [self showHint:@"手机号输入有误"];
     return;
     }];
     [[self.userF.rac_textSignal filter:^BOOL(id value) {
     NSString *text = value;
     return text.length == 11;
     }] subscribeNext:^(id x) {
     @strongify(self)
     self.pwdF.enabled = YES;
     [self.pwdF becomeFirstResponder];
     }];
     
     
     
     [[self.pwdF.rac_textSignal filter:^BOOL(id value) {
     NSString *text = value;
     return text.length >= 6;
     }] subscribeNext:^(id x) {
     @strongify(self)
     self.loginBtn.enabled = YES;
     }];
     
     */
    
    //登录点击事件
    [[self.loginBtn
      rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self showHudInView:self.view hint:@"正在登录请稍后..."];

        if (![self.userF.text isEqualToString:loginInform_Test[@"user"]] || ![self.pwdF.text isEqualToString:loginInform_Test[@"pwd"]]) {
            [self showHint:@"用户名或密码错误❌" yOffset:80];
            [self hideHud];

            return ;
        }else{
            
            NSDictionary *dict = @{@"user":self.userF.text,@"pwd":self.pwdF.text};
            [UserDefault setObject:dict forKey:@"user_login"];
            [UserDefault synchronize];
            
            AlertView *alertView = [AlertView shareInstanceWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeGetLogin];
            [alertView alertViewClose];
            
            [self hideHud];
        }

    }];
    
    //返回按钮点击事件
    [[self.backBtn
      rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        AlertView *alertView = [AlertView shareInstanceWithFrame:[UIScreen mainScreen].bounds AndAddAlertViewType:AlertViewTypeGetLogin];
        [alertView alertViewClose];
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *text = textField.text;
    
    if (textField.tag == 100001) {
        
        BOOL isMobMumber = [_tool isMobileNumber:text];
        
        if (!isMobMumber || text.length != 11) {
            [self showHint:@"手机号输入有误" yOffset:0];
            
            return;
        }
        
        self.pwdF.enabled = YES;

        
    }
    else if(textField.tag == 100002) {
        if (text.length < 6) {
            [self showHint:@"密码输入有误" yOffset:0];
            return;
        }
        
        self.loginBtn.enabled = YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userF resignFirstResponder];
    [self.pwdF resignFirstResponder];
    
}



@end
