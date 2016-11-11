//
//  CacheClass.h
//  LiXinDriverTest
//
//  Created by lixin on 16/11/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheClass : NSObject

@property (strong, nonatomic) NSCache *cache;

/**
 *  用户单例类
 *
 *  @return 返回一个用户对象
 */
+ (CacheClass *)cacheShareInstance;



/**
 *  YYCache基础缓存方法（存入）
 *
 *  @param value  值
 *  @param key    键
 */
+(void) cacheFromYYCacheWithValue:(id<NSCoding>) value AndKey:(NSString*) key;

/**
 *  YYCache基础缓存方法（取出）
 *
 *  @param key  键
 *
 *  @return 返回任意类型数据
 */
+(id) getAllDataFromYYCacheWithKey:(NSString*) key;


/**
 *  设置本地数据(基类)
 *
 *  @param cacheKey 本地缓存键值
 *  @param cache    本地缓存
 */
+ (void)setCacheWithKey:(NSString *)cacheKey cacheValue:(id)cache;


/**
 *  读取本地缓存(基类)
 *
 *  @param cacheKey 本地缓存键值
 *
 *  @return 返回键值对应的value
 */
+ (id)getCacheWithCacheKey:(NSString *)cacheKey;

/**
 *  保存首次登录 1 ＝ 不是首次登录
 *
 *  @param string
 */
+(void)saveUserIsFirstLoginWithSting:(NSString*) string;

/**
 *  查询用户是否首次登录 0 = 是首次登录， 1 ＝ 否
 *  @return
 */
+(NSString*)getUserIsFirstLogin;


@end
