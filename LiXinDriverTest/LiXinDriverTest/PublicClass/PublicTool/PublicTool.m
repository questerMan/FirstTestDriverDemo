//
//  PublicTool.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/6.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "PublicTool.h"

@implementation PublicTool
/** 单例 */
+ (PublicTool *)shareInstance{
    
    static dispatch_once_t onceToken;
    static PublicTool * shareTools = nil;
    dispatch_once(&onceToken, ^{
        shareTools = [[PublicTool alloc]init];
        
    });
    return shareTools;
}

#pragma mark - ============ 1.系统类🔧 ============

#pragma mark - 获取当前version号，并转化成int类型, 例:@111
+(int) getVersionNum
{
    NSMutableString *str1 = [NSMutableString stringWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == '"' || c == '.' || c == ',' || c == '(' || c == ')') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    
    NSString *newstr = [NSString stringWithString:str1];
    
    int versionNum = [newstr intValue];
    
    return versionNum;
}


/** 计算字符串长度*/
+(CGFloat)lengthofStr:(NSString *)str AndSystemFontOfSize:(CGFloat) fontSize{
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGSize size= [str sizeWithAttributes:attrs];
    return size.width;
    
}

#pragma mark - - 拨打电话☎️
+ (void)callPhoneWithPhoneNum:(NSString *)phoneNumberStr
{
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumberStr]]];
}

/** 获取UUID */
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (__bridge NSString *)CFStringCreateCopy(NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

/** 获取时间戳 */
-(NSString *) getTime {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", a];//转为字符型
    return timeString;
}



/** 绘制圆形图片 */
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    
    CGContextSetLineWidth(context,2);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}

/** 设置图片大小 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
#pragma mark - 颜色转图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - 首次打开app
+(int)isFirstOpenApp
{
    
    return [[UserDefault objectForKey:@"frist"] intValue];
    
}

#pragma mark - 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}
#pragma mark - 手机号处理－带星号
+(NSString *)setStartOfMumber:(NSString *)mumber{
   
    NSString *mum=[mumber stringByReplacingOccurrencesOfString:[mumber substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    return mum;
}

#pragma mark - - 发送通知
+(void)postNotificationWithName:(NSString *)nameStr object:(id)userInfoObject
{
    [[NSNotificationCenter defaultCenter]postNotificationName:nameStr object:nil userInfo:userInfoObject];
}

#pragma mark - - 接收通知
-(void)getNotificationWithName:(NSString *)nameStr object:(NotificationBlock)userInfoObjectBlock{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvBcast:) name:nameStr object:nil];
    
    _userInfoObjectBlock = userInfoObjectBlock;
    
}
- (void) recvBcast:(NSNotification *)notify{
    _userInfoObjectBlock(notify);
}

#pragma mark - - UTF8 字符转换
+ (NSString *)UTF8String:(NSString *)str
{
    NSString *changedStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return changedStr;
}
@end
