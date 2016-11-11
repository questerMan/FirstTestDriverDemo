//
//  CacheClass.m
//  LiXinDriverTest
//
//  Created by lixin on 16/11/7.
//  Copyright © 2016年 陆遗坤. All rights reserved.
//

#import "CacheClass.h"

#define fileQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


NSString *const UserCurrentLocation = @"UserCurrentLocation";

static CacheClass *userInfo = nil;


@implementation CacheClass

+ (CacheClass *)cacheShareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[CacheClass alloc]init];
        
    });
    return userInfo;
}


#pragma mark ===== NSCache =====
#pragma mark - 存储
-(void)write:(NSDictionary*) dictionary forKey:(NSString*)key
{
    
    _cache = [[NSCache alloc]init];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *filepath  = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    [_cache setObject:data forKey:key];
    
    NSLog(@"data == %@",data);
    
    dispatch_async(fileQueue, ^{
        
        [[NSFileManager defaultManager] createFileAtPath:filepath contents:data attributes:nil];
        
    });
    
}

#pragma mark - 读取
-(NSDictionary*)readForKey:(NSString*)key
{
    _cache = [[NSCache alloc]init];
    
    NSDictionary *dictionary = [NSDictionary dictionary];
    
    if(key==nil){
        
        return nil;
        
    }
    
    NSData *cacheData = [_cache objectForKey:key];
    
    if(cacheData){
        
        NSLog(@"get data from cache");
        
        dictionary = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        
        return dictionary;
        
    }else{
        
        NSLog(@"miss data from cache");
        
        NSString *filepath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSData *fileData =  [[NSFileManager defaultManager] contentsAtPath:filepath];
        
        
        
        if(fileData){
            
            [_cache setObject:fileData forKey:key];
            
            dictionary = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
            
        }
        
        return dictionary;
        
    }
    
}


#pragma mark ===== YYCache =====
#pragma mark - 基础存数据
/* 存数据
 *  yyCache路径-->/Users/fantastrip/Library/Developer/CoreSimulator/Devices/61EE0C32-988C-46ED-BEE4-7BFB7687E51E/data/Containers/Data/Application/83B32B42-7117-48D1-8913-5A30A0828F53/Library/Caches/allCacheData
 */
+(void) cacheFromYYCacheWithValue:(id<NSCoding>) value AndKey:(NSString*) key
{
    if (!value) return;
    
    YYCache * yyCache = [[YYCache alloc]initWithName:ALL_CACHE_DATA];
    
    NSLog(@"yyCache路径-->%@",yyCache.diskCache.path);
    
    [yyCache setObject:value forKey:key];
}

#pragma mark - 基础取数据
+(id) getAllDataFromYYCacheWithKey:(NSString*) key
{
    if (key.length == 0) return nil;
    
    YYCache * yyCache = [[YYCache alloc]initWithName:ALL_CACHE_DATA];
    
    return [yyCache objectForKey:key];
}




#pragma mark ===== NSUserDefault =====
#pragma mark - - 本地缓存基类
+ (void)setCacheWithKey:(NSString *)cacheKey cacheValue:(id)cache
{
    
    if (cache != nil) {  //判断缓存数据是否为空
        
        //        [UserDefault removeObjectForKey:cacheKey];
        
        [UserDefault setObject:cache forKey:cacheKey];
        [UserDefault synchronize];
    }
    
}

#pragma mark - - 返回本地数据基类
+ (id)getCacheWithCacheKey:(NSString *)cacheKey
{
    return [UserDefault objectForKey:cacheKey];
}

#pragma mark - 存储用户是否第一次登录
+(void)saveUserIsFirstLoginWithSting:(NSString*) string
{
    [CacheClass setCacheWithKey:USER_FIRST_LOGIN cacheValue:string];
}

#pragma mark - 取本地,用户是否第一次登录
+(NSString*)getUserIsFirstLogin{
    
    return [CacheClass getCacheWithCacheKey:USER_FIRST_LOGIN];
}


@end
