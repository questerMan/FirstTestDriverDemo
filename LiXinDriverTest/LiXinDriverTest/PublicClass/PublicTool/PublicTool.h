//
//  PublicTool.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>
//通知
typedef void (^NotificationBlock)(NSNotification *notify);
//返回代码块
typedef void (^BackBlock) (void);


@interface PublicTool : NSObject

/**
 *  工具单例类
 *
 *  @return 返回一个工具对象🔧
 */
+ (PublicTool *)shareInstance;

/**
 *  获取当前version号，并转化成int类型, 例:@111
 *
 *  @return version号
 */
+(int) getVersionNum;

/** 计算字符串长度*/
+(CGFloat)lengthofStr:(NSString *)str AndSystemFontOfSize:(CGFloat) fontSize;

/**
 *	@brief	传入电话号码，拨打电话
 *
 */
+ (void)callPhoneWithPhoneNum:(NSString *)phoneNumberStr;

/**
 *	@brief	获取UUID
 */
-(NSString*) uuid;

/**
 *	@brief	获取时间戳
 */
-(NSString *) getTime;


/**
 *	@brief	绘制圆形图片
 */
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

/**
 *	@brief	设置图片大小
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
/**
 *	@brief	颜色转图片
 */
+(UIImage*) createImageWithColor:(UIColor*) color;

/**
 *  是否第一次打开app 0 = 首次，1 ＝ 不是首次
 *
 *  @return 1第一
 */
+ (int)isFirstOpenApp;


/**
 *  正则判断手机号码地址格式
 *
 *  @return  Yes正确✅
 */
- (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  手号做星号处理
 *
 *  @return  处理过的手机号 188*＊＊＊6403
 */
+(NSString *)setStartOfMumber:(NSString *)mumber;
/**
 *  发送通知
 *
 *  @param nameStr        通知名
 *  @param userInfoObject 附带参数
 */
+ (void)postNotificationWithName:(NSString *)nameStr object:(id)userInfoObject;

//通知
@property (nonatomic,copy) NotificationBlock userInfoObjectBlock;

/**
 *  接收通知
 *
 *  @param nameStr        通知名
 *  @param userInfoObjectBlock 收到通知执行的方法
 */
- (void)getNotificationWithName:(NSString *)nameStr object:(NotificationBlock)userInfoObjectBlock;

/**
 *  字符转换F8
 *
 *  @param str 需转换的字符串
 *
 *  @return 转换后的字符串
 */
+ (NSString *)UTF8String:(NSString *)str;


//返回按钮
@property (nonatomic, copy) BackBlock backBlock;

/**
*  　创建返回按钮
*
*  @param viewController 要创建按钮的页面
*
*  @param backBlock 执行方法
*/
-(void)creatLeftBackItemToMainVCWithViewController:(UIViewController *)viewController
                                      andBackBlock:(BackBlock) backBlock;

@end
