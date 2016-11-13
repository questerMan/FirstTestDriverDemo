//
//  AlertView.h
//  AlertViewDemo
//
//  Created by lixin on 16/10/20.
//  Copyright © 2016年 lixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView
typedef enum {
    
//    AlertViewTypeGetPay, //
//    AlertViewTypeGetCar //
    
    AlertViewTypeGetLogin,
    AlertViewTypeGetDownLoad,
    AlertViewTypeGetMap
}AlertViewType;

@property (nonatomic, assign) AlertViewType addAlertViewType;

/**
 *  工具单例类
 *
 *  @return 返回一个对象
 */
+ (AlertView *)shareInstanceWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType;


-(instancetype)initWithFrame:(CGRect)frame AndAddAlertViewType:(AlertViewType)alertViewType;

-(void)alertViewShow;

-(void)alertViewClose;

@end
